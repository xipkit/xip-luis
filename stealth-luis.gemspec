Gem::Specification.new do |s|
  s.name        = 'stealth-luis'
  s.version     = '0.9.0'
  s.summary     = "Stealth LUIS"
  s.description = "Built-in NLP for Stealth bots via Microsoft's Language Understanding (LUIS)."
  s.authors     = ["Mauricio Gomes"]
  s.email       = 'mauricio@edge14.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'http://github.com/hellostealth/stealth-luis'
  s.license     = 'MIT'

  s.add_dependency 'stealth', '~> 2.0'
  s.add_dependency 'http', '~> 4'

  s.add_development_dependency "rspec", "= 3.8.0"

end