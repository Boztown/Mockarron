
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mockarron/version"

Gem::Specification.new do |spec|
  spec.name          = "mockarron"
  spec.version       = Mockarron::VERSION
  spec.authors       = ["Ryan Bosinger"]
  spec.email         = ["rbosinger@gmail.com"]

  spec.summary       = %q{Write a short summary, because RubyGems requires one.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = "https://www.ryanbosinger.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://www.ryanbosinger.com"
    spec.metadata["changelog_uri"] = "https://www.ryanbosinger.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry-byebug', '3.9.0'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'deep-cover', '~> 1.0.0'
  spec.add_dependency 'sinatra', '3.0.4'
  spec.add_dependency "thor"
  spec.add_dependency 'json', '2.3.1'
  spec.add_dependency 'yaml', '0.1.0'
end
