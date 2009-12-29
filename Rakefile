require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "monkeysupport"
    gem.summary = "Monkeypatching Rails with C since 2009"
    gem.description = "MonkeySupport monkeypatches some of the performance-sink parts of rails with speedy C extensions."
    gem.email = "burke@burkelibbey.org"
    gem.homepage = "http://github.com/burke/monkeysupport"
    gem.authors = ["Burke Libbey"]
    gem.files.include '{spec,lib,ext}/**/*'
    gem.extensions = ["ext/monkeysupport_c/extconf.rb", "ext/monkeysupport_output_safety/extconf.rb"]
    gem.add_development_dependency "shoulda"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'spec'
    test.pattern = 'spec/**/*_spec.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "monkeysupport #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
