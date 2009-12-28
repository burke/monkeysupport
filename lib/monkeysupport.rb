require 'monkeysupport/c_proxy'
require 'monkeysupport/memoizable'

require 'monkeysupport_c'

unless $MonkeyModuleExcludes && $MonkeyModuleExcludes.include? "inflector"
  require 'monkeysupport/activesupport/inflector'
end
  
unless $MonkeyModuleExcludes && $MonkeyModuleExcludes.include? "output_safety"
  if ["1.8.7", "1.9.1"].include? RUBY_VERSION
    require 'output_safety_ext'
  else
    puts "** MonkeySupport: output_safety module was not designed to work with #{RUBY_VERSION}. Extension not loaded."
  end
end
