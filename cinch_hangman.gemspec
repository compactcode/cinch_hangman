# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cinch_hangman/version"

Gem::Specification.new do |s|
  s.name        = "cinch_hangman"
  s.version     = CinchHangman::VERSION
  s.authors     = ["Shanon McQuay"]
  s.email       = ["shanonmcquay@gmail.com"]
  s.homepage    = "https://github.com/compactcode/cinch_hangman"
  s.summary     = %q{Let your IRC bot conduct a game of hangman.}

  s.rubyforge_project = "cinch_hangman"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "cinch"
  s.add_development_dependency "rspec"
end
