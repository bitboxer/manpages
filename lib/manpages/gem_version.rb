module Manpages
  class GemVersion
    def initialize(gem_spec)
      @gem_spec = gem_spec
    end

    def latest?
      latest_gem.nil? || latest_gem <= @gem_spec.version
    end

  private

    def latest_gem
      all_gem_versions.sort.last
    end

    def all_gem_versions
      Gem::Specification.each.select {|spec| @gem_spec.name == spec.name }.map(&:version)
    end
  end
end
