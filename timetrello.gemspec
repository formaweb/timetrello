lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_trello/version'

Gem::Specification.new do |spec|
  spec.name             = 'timetrello'
  spec.version          = TimeTrello::VERSION
  spec.license          = 'MIT'

  spec.authors          = ['Caio Tarifa', 'Ronaldo Faria Lima']
  spec.email            = ['caiotarifa@gmail.com', 'ronaldo@nineteen.com.br']
  spec.description      = %q{Trello time tracking.}
  spec.summary          = %q{Trello time tracking with Ruby.}
  spec.homepage         = 'formaweb.github.io/timetrello'

  spec.files            = `git ls-files lib`.split($/)
  spec.test_files       = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths    = ['lib']

  spec.rdoc_options     = ['--charset=UTF-8']
  spec.extra_rdoc_files = ['readme.me']

  spec.add_runtime_dependency 'ruby-trello', '~> 1.4',  '>= 1.4.1'
end
