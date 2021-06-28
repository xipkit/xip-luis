$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'xip-luis'
  s.version     = '1.2.2'
  s.summary     = "LUIS NLP Xip Kit Component"
  s.description = "Built-in NLP for Xip Kit via Microsoft's Language Understanding (LUIS)."
  s.authors     = ["Mauricio Gomes"]
  s.email       = 'mauricio@edge14.com'
  s.homepage    = 'http://github.com/xipkit/xip-luis'
  s.license     = 'MIT'

  s.add_dependency 'xip', '~> 2.0.0.beta'
  s.add_dependency 'http', '>= 4', '< 6'

  s.add_development_dependency "rspec", "~> 3"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
