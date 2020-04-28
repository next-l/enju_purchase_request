$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "enju_purchase_request/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_purchase_request"
  s.version     = EnjuPurchaseRequest::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["nabeta@fastmail.fm"]
  s.homepage    = "https://github.com/next-l/enju_purchase_request"
  s.summary     = "enju_purchase_request plugin"
  s.description = "Purchase request management for Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/{data,pids,default,development,test}/*"] - Dir["spec/dummy/tmp/*"]

  s.add_dependency "statesman", "~> 7.1"

  #s.add_development_dependency "enju_leaf", "~> 1.2.0"
  #s.add_development_dependency "enju_bookmark", "~> 0.2.0"
  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails", "~> 4.0"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "sunspot_solr", "~> 2.5"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "resque"
  s.add_development_dependency "rspec-activemodel-mocks"
  s.add_development_dependency "coveralls", '~> 0.8.23'
  s.add_development_dependency "annotate"
  s.add_development_dependency "brakeman"
end
