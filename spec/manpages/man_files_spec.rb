require "fileutils"

describe Manpages::ManFiles do
  context "#manpages" do
    it "returns a list of man files" do
      expect(Manpages::ManFiles.new("spec/data", "").manpages.map(&:to_s)).to match_array [
        "spec/data/man/example.1",
        "spec/data/man/example.2",
      ]
    end
  end

  context "#man_dir" do
    it "returns the man directory within the gem" do
      expect(Manpages::ManFiles.new("spec/data", "").man_dir).to eq Pathname("spec/data/man")
    end
  end

  context "#man_file_path" do
    it "returns the target path of the man file" do
      expect(
        Manpages::ManFiles.new("spec/data", "spec/tmp/man").man_file_path("example.1")
      ).to eq "spec/tmp/man/man1/example.1"
    end
  end
end
