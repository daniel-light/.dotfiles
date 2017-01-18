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
  s.files = ['lib/pomo.rb']
  s.executables = ['pomo']
end
