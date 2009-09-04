# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{monkeysupport}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Burke Libbey"]
  s.date = %q{2009-09-04}
  s.description = %q{MonkeySupport provides C implementations for some of the more intensive string manipulation methods in activesupport. ActionView is up next.}
  s.email = %q{burke@burkelibbey.org}
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "ext/Makefile",
     "ext/active_support_c.bundle",
     "ext/active_support_c.c",
     "ext/active_support_c.o",
     "ext/core_ext/string/access.c",
     "ext/core_ext/string/access.h",
     "ext/core_ext/string/filters.c",
     "ext/core_ext/string/filters.h",
     "ext/core_ext/string/starts_ends_with.c",
     "ext/core_ext/string/starts_ends_with.h",
     "ext/extconf.rb",
     "ext/inflector.c",
     "ext/inflector.h",
     "ext/inflector.o",
     "lib/monkeysupport.rb",
     "lib/monkeysupport.rb",
     "lib/monkeysupport/inflector.rb",
     "test/monkeysupport_test.rb",
     "test/monkeysupport_test.rb",
     "test/test_helper.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/burke/monkeysupport}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Monkeypatching Rails with C since 2009}
  s.test_files = [
    "test/monkeysupport_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end
