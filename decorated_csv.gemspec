Gem::Specification.new do |s|
  s.name        = 'decorated_csv'
  s.version     = '0.0.1'
  s.date        = '2013-03-11'
  s.summary     = "CSV generator utilising the decorator pattern"
  s.authors     = ["Dan Galipo"]
  s.email       = 'dan@thefrontiergroup.com.au'
  s.files       = ["lib/decorated_csv.rb"]
  s.homepage    = 'http://github.com/thefrontiergroup/tfg-decorated_csv'
  s.required_ruby_version = '>= 1.9.3'
  s.add_dependency "draper", '>= 1.1.0'

  s.add_development_dependency "rspec"
  # s.add_development_dependency "rspec_junit_formatter"
end