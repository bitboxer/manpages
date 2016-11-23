require "pathname"

module Manpages
  class ManFiles
    attr_reader :man_dir

    def initialize(gem_dir, target_dir = "")
      @target_dir = Pathname(target_dir)
      @man_dir = Pathname(File.join(gem_dir, "man"))
    end

    def manpages_present?
      !manpages.empty?
    end

    def manpages
      return [] unless man_dir.directory?

      Dir[man_dir.join("**/*")].select do |file|
        file =~ /\.\d$/
      end.map {|file| Pathname.new(file) }
    end

    def man_file_path(file)
      man_section = file.extname.match(/\.(\d*)/)
      @target_dir.join("man#{man_section[1]}", file.basename)
    end
  end
end
