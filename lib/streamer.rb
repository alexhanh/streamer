require "streamer/version"

module Streamer
  require 'streamer/sites/justin_tv'
  require 'streamer/sites/own3d'
  
  def self.setup(site)    
    if [:justintv, :twitchtv].include? site.to_sym
      return Sites::JustinTv.new
    end
    
    if :own3d == site.to_sym
      return Sites::Own3D.new
    end
  end
end