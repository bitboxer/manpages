module Manpages

  class Install

    def initialize(gem_dir, target_dir)
      @gem_dir    = gem_dir
      @target_dir = target_dir
    end

    def install_manpages
      manpages.each do |file|
        copy_manpage(file)
      end
    end

    private

    def copy_manpage(file)
      man_dir = File.join(@target_dir, "man#{File.extname(file)[1..-1]}")
      FileUtils.mkdir_p(man_dir)
      FileUtils.cp(file, man_dir)
    end

    def manpages
      Dir.entries(man_dir).select do |file|
        file =~ /(.+).\d$/
      end.map {|file| File.join(man_dir, file) }
    end

    def man_dir
      @man_dir ||= File.join(@gem_dir, 'man')
    end

  end

end
