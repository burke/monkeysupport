require 'monkeysupport/c_proxy'
require 'monkeysupport/memoizable'

require 'monkeysupport_c'

module_loaders = {
  "inflector" => lambda{
    require 'monkeysupport/activesupport/inflector'
  },

  "output_safety" => lambda{
    if ["1.8.7", "1.9.1"].include? RUBY_VERSION
      require 'monkeysupport_output_safety'
    else
      puts "##MonkeySupport: output_safety module not supported by #{RUBY_VERSION}. Module not loaded."
    end
  }
}

modules = module_loaders.keys
if $MonkeyModuleIncludes
  modules &= $MonkeyModuleIncludes # intersection
end
if $MonkeyModuleExcludes
  modules -= $MonkeyModuleExcludes # difference
end

modules.each do |mdl|
  module_loaders[mdl].call
end
