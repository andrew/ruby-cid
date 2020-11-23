require_relative 'lib/cid/version'

Gem::Specification.new do |spec|
  spec.name          = "cid"
  spec.version       = Cid::VERSION
  spec.authors       = ["Andrew Nesbitt"]
  spec.email         = ["andrewnez@gmail.com"]

  spec.summary       = %q{: Ruby library for parsing ipfs and multiformat cids}
  spec.homepage      = "https://github.com/andrew/ruby-cid"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'base58'
  spec.add_dependency 'multihashes'
  spec.add_dependency 'multibases'
  spec.add_dependency 'multicodecs'
end
