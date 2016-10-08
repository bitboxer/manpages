require 'rubygems/command_manager'
require 'manpages'

Gem::CommandManager.instance.register_command(:manpages)

Gem.post_install do |installer|
  source_dir = installer.spec.gem_dir
  target_dir = File.join(installer.bin_dir, "../share/man")

  Manpages::Install.new(source_dir, target_dir).install_manpages
end

Gem.post_uninstall do |uninstaller|
  source_dir = uninstaller.spec.gem_dir
  target_dir = File.join(uninstaller.bin_dir, "../share/man")

  Manpages::Uninstall.new(source_dir, target_dir).uninstall_manpages
end
