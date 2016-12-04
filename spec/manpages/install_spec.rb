require "fileutils"

describe Manpages::Install do
  after do
    FileUtils.rm_r "spec/tmp"
  end

  it "copies the man pages to a correct directory structure" do
    Manpages::Install.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array [
      "spec/tmp/man/man1",
      "spec/tmp/man/man1/example.1",
      "spec/tmp/man/man1/extra.1",
      "spec/tmp/man/man2",
      "spec/tmp/man/man2/example.2",
    ]
  end

  it "ignores gems without a man dir" do
    Manpages::Install.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/non_existent",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array []
  end

  it "Does not install if version is too old" do
    expect_any_instance_of(Manpages::GemVersion).to receive(:latest?).and_return(false)
    Manpages::Install.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array []
  end

  it "does not overwrite file if it is not a symlink" do
    FileUtils.mkdir_p "spec/tmp/man/man1"
    FileUtils.touch "spec/tmp/man/man1/example.1"
    Manpages::Install.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(File.symlink?("spec/tmp/man/man1/example.1")).to be_falsy
  end

  it "overwrite file if it is a symlink" do
    FileUtils.mkdir_p "spec/tmp/man/man1"
    FileUtils.ln_s("README.md", "spec/tmp/man/man1/example.1")
    Manpages::Install.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(File.symlink?("spec/tmp/man/man1/example.1")).to be_truthy
    expect(File.readlink("spec/tmp/man/man1/example.1")).to eql "spec/data/man/example.1"
  end

  it "handles permission problems gracefully" do
    FileUtils.mkdir_p("spec/tmp")
    FileUtils.chmod(400, "spec/tmp")

    expect do
      Manpages::Install.new(
        Gem::Specification.new(name: "manpages_test"),
        "spec/data",
        "spec/tmp/man",
      ).install_manpages
    end.to output(
      "Problems creating symlink spec/tmp/man/man1/example.1\n" \
      "Problems creating symlink spec/tmp/man/man2/example.2\n" \
      "Problems creating symlink spec/tmp/man/man1/extra.1\n"
    ).to_stdout
  end
end
