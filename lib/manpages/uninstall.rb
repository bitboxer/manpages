module Manpages

  class Uninstall

    def initialize(gem_spec, gem_dir, target_dir)
      @gem_spec   = gem_spec
      @gem_dir    = gem_dir
      @target_dir = target_dir
    end

    def uninstall_manpages
      unlink_manpages if GemVersion.new(@gem_spec).is_latest?
    end

    private

    def unlink_manpages
      ManFiles.new(@gem_dir, @target_dir).manpages.each do |file|
        unlink_manpage(file)
      end
    end

    def unlink_manpage(file)
      man_target_file = ManFiles.new(@gem_dir, @target_dir).man_file_path(file)
      if File.symlink?(man_target_file) && File.readlink(man_target_file) == file
        FileUtils.rm(man_target_file)
      end
    end

  end
end
