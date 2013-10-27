Gem::Specification.new do |s|
  s.platform    = Gem::Platform.new(['x86_64', 'darwin']) # at least Mountain Lion
  s.name        = 'dns'
  s.version     = '0.0.3'
  s.date        = '2013-10-26'
  s.summary     = "A gem for configuring DNS on OS X"
  s.description = "A gem for configuring DNS on OS X"

  s.required_ruby_version     = '>= 1.9.3'
  s.required_rubygems_version = '>= 1.8.11'

  s.license     = 'MIT'

  s.authors     = "dismory"
  s.email       = 'dismory@gmail.com'
  s.homepage    = 'https://github.com/dismory/dns'

  s.files       = ["lib/dns.rb"]
  s.executables << 'dns'
end
