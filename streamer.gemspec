# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "streamer/version"

Gem::Specification.new do |s|
  s.name        = "streamer"
  s.version     = Streamer::VERSION
  s.authors     = ["Alexander Hanhikoski"]
  s.email       = ["alexander.hanhikoski@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Library to get info about live streams on Justin.tv and own3D.}
  s.description = %q{Library to get info about live streams on Justin.tv and own3D.}

  s.rubyforge_project = "streamer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_dependency('httparty', '~> 0.8.1')
  s.add_dependency('activesupport', '~> 3.1.1')
end
