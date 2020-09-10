Gem::Specification.new do |s|
  s.name        = 'concord'
  s.version     = '0.1.6'
  s.authors     = ['Markus Schirp']
  s.email       = ['mbj@schirp-dso.com']
  s.homepage    = 'https://github.com/mbj/concord'
  s.summary     = 'Helper for object composition'
  s.license     = 'MIT'
  s.description = s.summary

  s.files         = Dir.glob('lib/**/*')
  s.require_paths = %w(lib)

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency('adamantium', '~> 0.2.0')
  s.add_dependency('equalizer',  '~> 0.0.9')

  s.add_development_dependency('devtools', '~> 0.1.26')
end
