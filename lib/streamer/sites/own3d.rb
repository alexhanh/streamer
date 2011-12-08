require 'httparty'
require 'active_support/time'

require 'streamer/stream'

module Streamer
  module Sites
    class Own3D
      include HTTParty
      base_uri 'http://api.own3d.tv'
      format :xml
      
      def list(params={})   
        begin
          data = self.class.get('/live', :query => params)
        rescue StandardError => e
          p e
          return nil
        end
        
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
      
      protected
      def parse_stream(item)
        url = item['link']
        id = url[/\d+$/]
        name = item['credit']
        
        viewers = item['misc']['viewers'].to_i
        live_since = item['misc']['duration'].to_i.seconds.ago
        
        capture_url = item['thumbnail'][0]                
        title = item['title'][0]
        
        
        
        return Stream.new(:id => id,
                          :name => name,
                          :is_live => true, 
                          :viewers => viewers, 
                          :live_since => live_since, 
                          :url => url, 
                          :capture_url => capture_url,
                          :title => title)
      end
    end
  end
end