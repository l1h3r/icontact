# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name          = 'icontact'
  gem.version       = '0.0.6'
  gem.authors       = ['Devin Turner']
  gem.email         = ['devin.turner09@gmail.com']
  gem.summary       = 'Ruby wrapper for the iContact API'
  gem.homepage      = 'https://github.com/l1h3r/icontact'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r( ^bin/ )).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r( ^(test|spec|features)/ ))
  gem.require_paths = ['lib']

  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')

  gem.add_runtime_dependency 'oj',          '~> 2.11'
  gem.add_runtime_dependency 'faraday',     '~> 0.8'
  gem.add_development_dependency 'bundler', '~> 1.5'
  gem.add_development_dependency 'rake',    '~> 10.3'
  gem.add_development_dependency 'rspec',   '~> 3.0'
end
