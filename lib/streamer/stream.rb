module Streamer
  class Stream
    attr_reader :id, :embed_code, :viewers, :live_since, :is_live, :url, :capture_url, :title
    
    def initialize(attrs={})
      @id = attrs[:id]
      @viewers = attrs[:viewers]
      @is_live = attrs[:is_live]
      @live_since = attrs[:live_since]
      @url = attrs[:url]
      @capture_url = attrs[:capture_url]
      @title = attrs[:title]
    end
    
    # Returns how many seconds the stream has been up relative to the current time.
    def uptime
      Time.now - live_since
    end
    
    alias :live? :is_live
  end
end