# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pomo/version'

Gem::Specification.new do |s|
  s.name = 'pomo-daniel-light'
  s.version = Pomo::VERSION
  s.date = '2016-11-30'
  s.summary = 'My personal pomo timer'
  s.authors = ['Daniel Light']
  s.email = 'gem.pomo@daniel-light.net'
  s.files = Dir.glob('lib/**/*.rb')
  s.executables = ['pomo']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
