# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'timetrello/version'

Gem::Specification.new do |spec|
  spec.name          = 'timetrello'
  spec.version       = TimeTrello::VERSION
  spec.authors       = ['Caio Tarifa']
  spec.email         = ['caiotarifa@gmail.com']
  spec.description   = %q{Trello time tracking with Ruby.}
  spec.summary       = %q{Trello time tracking with Ruby.}
  spec.homepage      = ''
  spec.license       = ''

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'trello'
end
