module Manpages

  class Install

    def initialize(gem_dir, target_dir)
      @gem_dir    = gem_dir
      @target_dir = target_dir
    end

    def install_manpages
      manpages.each do |file|
        link_manpage(file)
      end
    end

    private

    def link_manpage(file)
      man_target_dir = File.join(@target_dir, "man#{File.extname(file)[1..-1]}")
      FileUtils.mkdir_p(man_target_dir)
      FileUtils.ln_s(file, man_target_dir, force: true)
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

  end

end
