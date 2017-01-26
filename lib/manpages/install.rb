require "fileutils"

module Manpages
  class Install
    def initialize(gem_spec, gem_dir, target_dir)
      @gem_spec   = gem_spec
      @gem_dir    = gem_dir
      @target_dir = target_dir
    end

    def install_manpages
      link_manpages if GemVersion.new(@gem_spec).latest?
    end

  private

    def link_manpages
      ManFiles.new(@gem_dir, @target_dir).manpages.each do |file|
        link_manpage(file)
      end
    end

    def link_manpage(file)
      man_target_file = ManFiles.new(@gem_dir, @target_dir).man_file_path(file)
      return if man_target_file.exist?

      begin
        FileUtils.mkdir_p(man_target_file.dirname)
        FileUtils.ln_s(file, man_target_file, force: true)
      rescue
        puts "Problems creating symlink #{man_target_file}"
      end
    end
  end
end
