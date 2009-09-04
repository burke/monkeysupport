require 'mkmf'
extension_name = 'monkeysupport_c'
dir_config(extension_name)
create_makefile(extension_name, 'src')
