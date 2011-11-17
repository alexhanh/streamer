require 'httparty'
require 'active_support/time'

require 'streamer/stream'

module Streamer
  module Sites
    class Own3D
      include HTTParty
      base_uri 'http://api.own3d.tv'
      format :xml
      
      def get_stream(id)
        data = self.class.get("/live?channel=#{id}&showAll")
        
        data = data['rss']['channel']['item']
        
        if data['thumbnail'][0] == 'http://img.own3d.tv/live/no-tn.jpg'
          return Stream.new(:is_live => false)
        end
        
        viewers = data['misc']['viewers'].to_i
        live_since = data['misc']['duration'].to_i.seconds.ago
          
        return Stream.new(:is_live => true, :viewers => viewers, :live_since => live_since)
      end
    end
  end
end