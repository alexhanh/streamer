module Streamer
  class Stream
    attr_reader :viewers, :live_since, :is_live
    
    def initialize(attrs={})
      @viewers = attrs[:viewers]
      @is_live = attrs[:is_live]
      @live_since = attrs[:live_since]
    end
    
    # Returns how many seconds the stream has been up relative to the current time.
    def uptime
      Time.now - live_since
    end
    
    alias :live? :is_live
  end
end