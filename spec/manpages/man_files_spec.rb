# frozen_string_literal: true

require "fileutils"

describe Manpages::ManFiles do
  describe "#manpages" do
    it "returns a list of man files" do
      expect(described_class.new("spec/data", "").manpages.map(&:to_s)).to contain_exactly(
        "spec/data/man/example.1",
        "spec/data/man/example.2",
        "spec/data/man/man1/extra.1",
      )
    end
  end

  describe "#man_dir" do
    it "returns the man directory within the gem" do
      expect(described_class.new("spec/data", "").man_dir).to eq Pathname("spec/data/man")
    end
  end

  describe "#manpages_present?" do
    it "returns true if manpages are found" do
      expect(described_class.new("spec/data")).to be_manpages_present
    end

    it "returns false if no manpages are found" do
      expect(described_class.new("spec/data2")).not_to be_manpages_present
    end
  end

  describe "#man_file_path" do
    it "returns the target path of the man file" do
      expect(
        described_class.new("spec/data", "spec/tmp/man").man_file_path(Pathname("example.1"))
      ).to eq Pathname("spec/tmp/man/man1/example.1")
    end
  end
end
