require "manpages"
require "rubygems/command_manager"
require "rubygems/version_option"

Gem::CommandManager.instance.register_command :manpages

Gem.post_install do |installer|
  source_dir = installer.spec.gem_dir
  target_dir = File.expand_path("#{installer.bin_dir}/../share/man")

  Manpages::Install.new(installer.spec, source_dir, target_dir).install_manpages
end

Gem.pre_uninstall do |uninstaller|
  bin_dir = uninstaller.bin_dir || Gem.bindir(uninstaller.spec.base_dir)
  source_dir = uninstaller.spec.gem_dir
  target_dir = File.expand_path("#{bin_dir}/../share/man")

  Manpages::Uninstall.new(uninstaller.spec, source_dir, target_dir).uninstall_manpages
end
