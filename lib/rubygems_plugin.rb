require 'rubygems/command_manager'
require 'manpages'

Gem::CommandManager.instance.register_command(:manpages)

Gem.post_install do |installer|
  source_dir = installer.spec.gem_dir
  target_dir = File.join(installer.bin_dir, "../share/man")

  Manpages::Install.new(source_dir, target_dir).install_manpages
end
