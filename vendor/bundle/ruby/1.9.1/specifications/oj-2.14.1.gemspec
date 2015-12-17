# -*- encoding: utf-8 -*-
# stub: oj 2.14.1 ruby lib
# stub: ext/oj/extconf.rb

Gem::Specification.new do |s|
  s.name = "oj"
  s.version = "2.14.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Peter Ohler"]
  s.date = "2015-12-15"
  s.description = "The fastest JSON parser and object serializer. "
  s.email = "peter@ohler.com"
  s.extensions = ["ext/oj/extconf.rb"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md", "ext/oj/extconf.rb"]
  s.homepage = "http://www.ohler.com/oj"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.rubyforge_project = "oj"
  s.rubygems_version = "2.5.0"
  s.summary = "A fast JSON parser and serializer."

  s.installed_by_version = "2.5.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.9"])
      s.add_development_dependency(%q<minitest>, ["~> 5"])
      s.add_development_dependency(%q<rails>, ["~> 4"])
    else
      s.add_dependency(%q<rake-compiler>, ["~> 0.9"])
      s.add_dependency(%q<minitest>, ["~> 5"])
      s.add_dependency(%q<rails>, ["~> 4"])
    end
  else
    s.add_dependency(%q<rake-compiler>, ["~> 0.9"])
    s.add_dependency(%q<minitest>, ["~> 5"])
    s.add_dependency(%q<rails>, ["~> 4"])
  end
end
