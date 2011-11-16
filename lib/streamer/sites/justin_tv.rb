require 'httparty'
require 'active_support/time'

require 'streamer/stream'

module Streamer
  module Sites
    class JustinTv
      include HTTParty
      base_uri 'http://api.justin.tv/api'
      
      def get_stream(id)
        data = self.class.get("/stream/list.json?channel=#{id}")

        for match in data
          if match['channel']['login'] == id
            
            Time.zone = match['channel']['timezone']
            live_since = Time.zone.parse(match['up_time'])
            
            viewers = match['channel_count'].to_i
            
            return Stream.new(:is_live => true, :viewers => viewers, :live_since => live_since)
          end      
        end        
        
        return Stream.new(:is_live => false)
      end
    end
  end
end