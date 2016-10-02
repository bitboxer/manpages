require 'rubygems/command_manager'

Gem::CommandManager.instance.register_command(:manpages)

Gem.post_install do |installer|
  puts "post install things"

  require 'pry'
  puts installer.spec.attributes.inspect
  # puts installer.inspect
  # Important things:
  puts installer.bin_dir
  puts installer.spec.gem_dir

  # TODO:
  # * find man files in gem_dir, look in gem-man for examples
  # * copy those to bin_dir/../share/man
  # * (but create sub directories for each man level)
  # * create hook for rbenv
  # * Add man_dir to metadata hash?!

end
