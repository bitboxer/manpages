require "fileutils"

describe Manpages::ManFiles do
  context "#manpages" do
    it "returns a list of man files" do
      expect(Manpages::ManFiles.new("spec/data", "").manpages.map(&:to_s)).to match_array [
        "spec/data/man/example.1",
        "spec/data/man/example.2",
        "spec/data/man/man1/extra.1",
      ]
    end
  end

  context "#man_dir" do
    it "returns the man directory within the gem" do
      expect(Manpages::ManFiles.new("spec/data", "").man_dir).to eq Pathname("spec/data/man")
    end
  end

  context "#manpages_present?" do
    it "returns true if manpages are found" do
      expect(Manpages::ManFiles.new("spec/data").manpages_present?).to be_truthy
    end

    it "returns false if no manpages are found" do
      expect(Manpages::ManFiles.new("spec/data2").manpages_present?).to be_falsy
    end
  end

  context "#man_file_path" do
    it "returns the target path of the man file" do
      expect(
        Manpages::ManFiles.new("spec/data", "spec/tmp/man").man_file_path(Pathname("example.1"))
      ).to eq Pathname("spec/tmp/man/man1/example.1")
    end
  end
end
