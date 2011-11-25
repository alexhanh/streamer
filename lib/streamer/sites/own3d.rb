require 'httparty'
require 'active_support/time'

require 'streamer/stream'

module Streamer
  module Sites
    class Own3D
      include HTTParty
      base_uri 'http://api.own3d.tv'
      format :xml
      
      def get_list()
        data = self.class.get('/live?game=sc2')
        
        streams = []
        
        if data['rss']['channel']['item'].kind_of?(Array)
          for item in data['rss']['channel']['item']
            streams << parse_stream(item)
          end
        else
          streams << parse_stream(data['rss']['channel']['item'])
        end
        
        return streams
      end
      
      # def get_stream(id)
      #   data = self.class.get("/live?channel=#{id}&showAll")
      #   
      #   return parse_stream(data['rss']['channel']['item'])
      # end
      
      protected
      def parse_stream(item)
        id = item['credit']
        
        # if item['thumbnail'][0] == 'http://img.own3d.tv/live/no-tn.jpg'
        #   return Stream.new(:is_live => false)
        # end
        
        viewers = item['misc']['viewers'].to_i
        live_since = item['misc']['duration'].to_i.seconds.ago
        
        url = item['link']
          
        return Stream.new(:id => id, :is_live => true, :viewers => viewers, :live_since => live_since, :url => url)
      end
    end
  end
end