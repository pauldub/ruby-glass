# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'glass/version'

Gem::Specification.new do |s|
  s.name          = "glass"
  s.version       = Glass::VERSION
  s.authors       = ["Paul d'Hubert"]
  s.email         = ["paul@tymate.com"]
  s.homepage      = "https://github.com//glass"
  s.summary       = "TODO: summary"
  s.description   = "TODO: description"

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'
end
