# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "frontier_generators"
  s.version     = "0.9.0"
  s.authors     = ["Jordan Maguire", "Vinicius Osiro"]
  s.email       = ["jordan@thefrontiergroup.com.au", "vinny@thefrontiergroup.com.au"]
  s.homepage    = "https://github.com/thefrontiergroup/frontier_generators"
  s.summary     = "Comprehensive generators for CRUD"
  s.description = <<-EOF
    Use in conjunction with the Rails Template (https://github.com/thefrontiergroup/rails-template)
    to quickly scaffold usable admin interfaces for models.
  EOF

  s.files         = Dir['README.md', 'lib/**/{*,.[a-z]*}']
  s.require_paths = ["lib"]
end