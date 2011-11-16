require 'httparty'

module Streamer
  module Sites
    class Own3D
      include HTTParty
      base_uri 'http://api.own3d.tv'
      format :xml
      
      def get_stream(id)
        data = self.class.get("/live?channel=#{id}&showAll")
        
        data = data['rss']['channel']
        
        if data['item']
          viewers = data['item']['misc']['viewers'].to_i
          live_since = data['item']['misc']['duration'].to_i.seconds.ago
          
          return Stream.new(:is_live => true, :viewers => viewers, :live_since => live_since)
        end
        
        return Stream.new(:is_live => false)
      end
    end
  end
end