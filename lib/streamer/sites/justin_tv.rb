require 'httparty'
require 'active_support/time'

require 'streamer/stream'

module Streamer
  module Sites
    class JustinTv
      include HTTParty
      base_uri 'http://api.justin.tv/api'
      
      def list(params={})
        begin
          response = self.class.get("/stream/list.json", :query => params)
        rescue StandardError => e
          p e
          # Errno::ETIMEDOUT, Errno::ECONNREFUSED, Errno::ECONNRESET, SocketError, Timeout::Error, etc.
          return nil
        end
        
        if response.code != 200
          p response.code
          return nil
        end

        streams = []          
        for stream in response
          streams << parse_stream(stream)
        end
        
        return streams
      end
      
      protected
      def parse_stream(data)
        id = data['channel']['login']
        
        Time.zone = data['channel']['timezone']
        live_since = Time.zone.parse(data['up_time'])
        
        viewers = data['channel_count'].to_i
        
        capture_url = data['channel']['screen_cap_url_medium']
        
        # Note: data['title'] seems to contain same content as data['channel']['status'] but
        # is not HTTP/URL (or something) encoded.
        # ie.
        # "Hello, this is SlayerSMin. thx see my stream.\\nhttp://slayersminfund.chipin.com/slayersmin-mlg-fund"
        # vs.
        # "Hello, this is SlayerSMin. thx see my stream.\nhttp://slayersminfund.chipin.com/slayersmin-mlg-fund"
        title = data['channel']['status']
        
        return Stream.new(:id => id, 
                          :is_live => true, 
                          :viewers => viewers, 
                          :live_since => live_since, 
                          :url => "http://www.twitch.tv/#{id}",
                          :capture_url => capture_url,
                          :title => title)
      end
    end
  end
end