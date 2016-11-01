require "pathname"

module Manpages
  class ManFiles
    def initialize(gem_dir, target_dir)
      @gem_dir    = gem_dir
      @target_dir = target_dir
      @man_dir = Pathname(File.join(@gem_dir, "man"))
    end

    def manpages
      return [] unless man_dir.directory?

      man_dir.children(false).select do |file|
        file.extname =~ /.\d$/
      end.map {|file| File.join(man_dir, file) }
    end

    def man_dir
      @man_dir
    end

    def man_file_path(filename)
      file = Pathname(filename)
      man_section = file.extname.match(/\.(\d*)/)
      File.join(@target_dir, "man#{man_section[1]}", file.basename)
    end
  end
end
