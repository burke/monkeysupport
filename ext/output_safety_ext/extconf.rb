require 'mkmf'

extension_name = 'output_safety_ext'
dir_config(extension_name)
create_makefile(extension_name, '.')
