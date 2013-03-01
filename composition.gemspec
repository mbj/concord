# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = 'composition'
  s.version     = '0.0.1'
  s.authors     = ['Markus Schirp']
  s.email       = ['mbj@seonic.net']
  s.homepage    = 'https://github.com/mbj/composition'
  s.summary     = %q{Helper for object composition}
  s.description = s.summary

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = []
  s.require_paths = ['lib']

  s.add_dependency('backports',           '~> 3.0.3')
  s.add_dependency('adamantium',          '~> 0.0.7')
  s.add_dependency('equalizer',           '~> 0.0.5')
end
