Gem::Specification.new do |s|
  s.name        = 'stealth-dialogflow'
  s.version     = '0.9.0'
  s.summary     = "Stealth Dialogflow"
  s.description = "Built-in NLP for Stealth bots via Google Dialogflow."
  s.authors     = ["Mauricio Gomes"]
  s.email       = 'mauricio@edge14.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://github.com/hellostealth/stealth-dialogflow'
  s.license     = 'MIT'

  s.add_dependency 'stealth', '~> 2.0'
  s.add_dependency 'google-cloud-dialogflow', '~> 0.6'

  s.add_development_dependency "rspec", "= 3.8.0"

end
