Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-concatenated_template_files-check'
  spec.version     = '0.1.1'
  spec.homepage    = 'https://github.com/deanwilson/puppet-lint-concatenated_template_files-check'
  spec.license     = 'MIT'
  spec.author      = 'Dean Wilson'
  spec.email       = 'dean.wilson@gmail.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'puppet-lint concatenated_template_files check'
  spec.description = <<-DESCRIPTION
    Extends puppet-lint to ensure all template functions expand a single
    file, rather than unexpectedly concatenating multiple template files in
    to a single string.
  DESCRIPTION

  spec.required_ruby_version = '>= 2.5.0'

  spec.add_dependency             'puppet-lint', '>= 1.1', '< 3.0'

  spec.add_development_dependency 'rake', '~> 13.0.0'
  spec.add_development_dependency 'rspec', '~> 3.11.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-json_expectations', '~> 2.2'
  spec.add_development_dependency 'rubocop', '~> 0.93.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.44.1'
  spec.add_development_dependency 'simplecov', '~> 0.21.0'
end
