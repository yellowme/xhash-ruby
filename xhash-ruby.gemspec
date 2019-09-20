Gem::Specification.new do |s|
  s.name        = 'xhash-ruby'
  s.version     = '0.1.0'
  s.date        = '2019-10-10'
  s.summary     = "Ruby Bindings for Xhash API"
  s.description = "Ruby Bindings for Xhash API"
  s.files       = ["lib/xhash-ruby.rb"]
  s.authors     = ["Yellowme"]
  s.email       = 'hola@yellowme.mx'
  s.homepage    = 'https://rubygems.org/gems/xhash-ruby'
  s.license      = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib','lib/finsus']

  s.add_dependency 'httparty'

  s.add_runtime_dependency 'json', '~> 1.8'
end
