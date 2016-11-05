class Gem::Commands::ManpagesCommand < Gem::Command
  include Gem::VersionOption

  def initialize
    super "manpages", "Handling manpages in gems",
      command: nil,
      version: Gem::Requirement.default,
      latest:  false,
      all:     false

    add_update_all_option
  end

  def usage
    "gem manpages"
  end

  def add_update_all_option
    add_option("-u", "--update-all",
      "Search for manpages in all installed gems and expose them to man") do |_, options|
      options[:update_all] = true
    end
  end

  def execute
    if options[:update_all]
      update_all
    else
      show_help
    end
  end

  def update_all
    specs = Gem::Specification.respond_to?(:each) ? Gem::Specification : Gem.source_index.gems
    specs.each do |*name_and_spec|
      spec = name_and_spec.pop
      next unless Manpages::ManFiles.new(spec.gem_dir).manpages_present? &&
          Manpages::GemVersion.new(spec).latest?

      say "Installing man pages for #{spec.name} #{spec.version}"
      target_dir = File.expand_path("#{Gem.bindir}/../share/man")
      Manpages::Install.new(spec, spec.gem_dir, target_dir).install_manpages
    end
  end
end
