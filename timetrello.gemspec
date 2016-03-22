# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-22
#
# GEM Spec for Time Trello

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_trello/version'

Gem::Specification.new do |spec|
  spec.name          = 'timetrello'
  spec.version       = TimeTrello::VERSION
  spec.authors       = ['Caio Tarifa', 'Ronaldo Faria Lima']
  spec.email         = ['caiotarifa@gmail.com', 'ronaldo@nineteen.com.br']
  spec.description   = %q{Trello time tracking.}
  spec.summary       = %q{Trello time tracking with Ruby.}
  spec.homepage      = 'http://www.formaweb.com.br'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'ruby-trello', '~> 1.4',  '>= 1.4.1'
end
