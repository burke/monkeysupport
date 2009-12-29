require 'mkmf'

extension_name = 'monkeysupport_output_safety'
dir_config(extension_name)
create_makefile(extension_name, 'src')
