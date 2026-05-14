# frozen_string_literal: true

FakeSpec = Struct.new(:name, :version)

describe Manpages::GemVersion do
  describe "#latest?" do
    it "Returns true if there is no other gem version" do
      gem_spec = Gem::Specification.new(name: "manpages_test")
      expect(described_class.new(gem_spec)).to be_latest
    end

    it "Returns true if it is the newest version" do
      gem_spec = Gem::Specification.new("manpages_test", Gem::Version.new("0.1.0"))
      allow(Gem::Specification).to receive(:each).and_return([
        FakeSpec.new("manpages_test", Gem::Version.new("0.0.1")),
      ])
      expect(described_class.new(gem_spec)).to be_latest
    end

    it "Returns false if it is not the newest version of a gem" do
      gem_spec = Gem::Specification.new("manpages_test", Gem::Version.new("0.1.0"))
      allow(Gem::Specification).to receive(:each).and_return([
        FakeSpec.new("manpages_test", Gem::Version.new("1.0.0")),
      ])
      expect(described_class.new(gem_spec)).not_to be_latest
    end
  end
end
