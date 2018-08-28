lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hif_baseline_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'hif_baseline_converter'
  spec.version       = HifBaselineConverter::VERSION
  spec.authors       = ['Mark']
  spec.email         = ['mark.rosel@madetech.com']

  spec.summary       = 'Converts HE baseline XLS into json schema'
  spec.homepage      = 'https://madetech.com'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'json_matchers'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec_junit_formatter'

  spec.add_dependency 'pry'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'json'
  spec.add_dependency 'roo'
  spec.add_dependency 'httparty'
end
