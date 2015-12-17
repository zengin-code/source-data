# coding: utf-8
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'romaji/version'

Gem::Specification.new do |gem|
  gem.authors       = ['Shimpei Makimoto']
  gem.email         = ['makimoto@tsuyabu.in']
  gem.description   = 'Yet another Romaji-Kana transliterator'
  gem.summary       = 'Yet another Romaji-Kana transliterator'
  gem.homepage      = "https://github.com/makimoto/romaji"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'romaji'
  gem.require_paths = ['lib']
  gem.version       = Romaji::VERSION

  gem.add_dependency('rake', '>= 0.8.0')
  gem.add_development_dependency('rspec', '>= 2.8.0')
  gem.add_development_dependency('pry', ['>= 0'])
  gem.add_development_dependency('guard', '>= 1.0.1')
  gem.add_development_dependency('guard-rspec', '>= 0.7.0')
  gem.add_development_dependency('growl', '>= 1.0.3')
  gem.add_development_dependency('coveralls')
end
