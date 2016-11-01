require "ostruct"

describe Manpages::GemVersion do
  context "#latest?" do
    it "Returns true if there is no other gem version" do
      gem_spec = Gem::Specification.new(name: "manpages_test")
      expect(Manpages::GemVersion.new(gem_spec).latest?).to be_truthy
    end

    it "Returns true if it is the newest version" do
      gem_spec = Gem::Specification.new("manpages_test", Gem::Version.new("0.1.0"))
      allow(Gem::Specification).to receive(:each).and_return([
        OpenStruct.new(name: "manpages_test", version: Gem::Version.new("0.0.1")),
      ])
      expect(Manpages::GemVersion.new(gem_spec).latest?).to be_truthy
    end

    it "Returns false if it is not the newest version of a gem" do
      gem_spec = Gem::Specification.new("manpages_test", Gem::Version.new("0.1.0"))
      allow(Gem::Specification).to receive(:each).and_return([
        OpenStruct.new(name: "manpages_test", version: Gem::Version.new("1.0.0")),
      ])
      expect(Manpages::GemVersion.new(gem_spec).latest?).to be_falsy
    end
  end
end
