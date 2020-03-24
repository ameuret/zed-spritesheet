require_relative 'lib/zed/spritesheet/version'

Gem::Specification.new do |spec|
  spec.name          = "zed-spritesheet"
  spec.version       = Zed::Spritesheet::VERSION
  spec.authors       = ["Arnaud Meuret"]
  spec.email         = ["arnaud@meuret.net"]

  spec.summary       = %q{A toolset to ease your life when dealing with sprite atlases.}
  spec.description   = %q{This tool generates source code declarations for sprites described in an XML or JSON atlas.}
  spec.homepage      = "https://meuret.itch.io/zed"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ameuret/spritesheet"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.add_dependency "oily_png"
  spec.add_dependency "chunky_png"
  
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ['ssex']
  spec.require_paths = ["lib"]
end
