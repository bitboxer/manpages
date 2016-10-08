module Manpages
  class ManFiles

    def initialize(gem_dir, target_dir)
      @gem_dir    = gem_dir
      @target_dir = target_dir
    end

    def manpages
      return [] unless File.directory?(man_dir)

      Dir.entries(man_dir).select do |file|
        file =~ /(.+).\d$/
      end.map {|file| File.join(man_dir, file) }
    end

    def man_dir
      @man_dir ||= File.join(@gem_dir, 'man')
    end

    def man_file_path(file)
      basename = File.basename(file)
      man_section = file.match(/.*\.(\d*)/)
      File.join(@target_dir, "man#{man_section[1]}", basename)
    end

  end
end
