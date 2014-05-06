# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'concord'
  s.version     = '0.1.5'
  s.authors     = ['Markus Schirp']
  s.email       = ['mbj@schirp-dso.com']
  s.homepage    = 'https://github.com/mbj/concord'
  s.summary     = %q{Helper for object composition}
  s.license     = 'MIT'
  s.description = s.summary

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = []
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency('adamantium', '~> 0.2.0')
  s.add_dependency('equalizer',  '~> 0.0.9')
end
