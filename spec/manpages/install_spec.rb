# frozen_string_literal: true

require "fileutils"

describe Manpages::Install do
  after do
    FileUtils.rm_r "spec/tmp"
  end

  it "copies the man pages to a correct directory structure" do
    described_class.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to contain_exactly(
      "spec/tmp/man/man1",
      "spec/tmp/man/man1/example.1",
      "spec/tmp/man/man1/extra.1",
      "spec/tmp/man/man2",
      "spec/tmp/man/man2/example.2",
    )
  end

  it "ignores gems without a man dir" do
    described_class.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/non_existent",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to be_empty
  end

  it "Does not install if version is too old" do
    allow(Manpages::GemVersion).to receive(:new).and_return(instance_double(Manpages::GemVersion, latest?: false))
    described_class.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to be_empty
  end

  it "does not overwrite file if it is not a symlink" do
    FileUtils.mkdir_p "spec/tmp/man/man1"
    FileUtils.touch "spec/tmp/man/man1/example.1"
    described_class.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(File).not_to be_symlink("spec/tmp/man/man1/example.1")
  end

  it "overwrite file if it is a symlink" do
    FileUtils.mkdir_p "spec/tmp/man/man1"
    FileUtils.ln_s("README.md", "spec/tmp/man/man1/example.1")
    described_class.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(File).to be_symlink("spec/tmp/man/man1/example.1")
    expect(File.readlink("spec/tmp/man/man1/example.1")).to eql "spec/data/man/example.1"
  end

  it "handles permission problems gracefully" do
    FileUtils.mkdir_p("spec/tmp")
    FileUtils.chmod(400, "spec/tmp")

    expect do
      described_class.new(
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
