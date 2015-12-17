# -*- encoding: utf-8 -*-
# stub: romaji 0.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "romaji"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Shimpei Makimoto"]
  s.date = "2015-03-27"
  s.description = "Yet another Romaji-Kana transliterator"
  s.email = ["makimoto@tsuyabu.in"]
  s.homepage = "https://github.com/makimoto/romaji"
  s.rubygems_version = "2.5.0"
  s.summary = "Yet another Romaji-Kana transliterator"

  s.installed_by_version = "2.5.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0.8.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.8.0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<guard>, [">= 1.0.1"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0.7.0"])
      s.add_development_dependency(%q<growl>, [">= 1.0.3"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0.8.0"])
      s.add_dependency(%q<rspec>, [">= 2.8.0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<guard>, [">= 1.0.1"])
      s.add_dependency(%q<guard-rspec>, [">= 0.7.0"])
      s.add_dependency(%q<growl>, [">= 1.0.3"])
      s.add_dependency(%q<coveralls>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8.0"])
    s.add_dependency(%q<rspec>, [">= 2.8.0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<guard>, [">= 1.0.1"])
    s.add_dependency(%q<guard-rspec>, [">= 0.7.0"])
    s.add_dependency(%q<growl>, [">= 1.0.3"])
    s.add_dependency(%q<coveralls>, [">= 0"])
  end
end
