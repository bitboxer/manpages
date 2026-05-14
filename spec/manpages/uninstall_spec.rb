# frozen_string_literal: true

require "fileutils"

describe Manpages::Uninstall do
  before do
    FileUtils.mkdir_p("spec/tmp/man/man1")
  end

  after do
    FileUtils.rm_r "spec/tmp"
  end

  it "Deletes a manpage if the link is to this gem" do
    FileUtils.ln_s("spec/data/man/example.1", "spec/tmp/man/man1/example.1")
    described_class.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).uninstall_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to contain_exactly("spec/tmp/man/man1")
  end

  it "Does not delete a manpage if it does not link to this gem" do
    FileUtils.ln_s("README.md", "spec/tmp/man/man1/example.1")
    described_class.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/non_existent",
      "spec/tmp/man"
    ).uninstall_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to contain_exactly(
      "spec/tmp/man/man1",
      "spec/tmp/man/man1/example.1",
    )
  end

  it "Does not uninstall if version is too old" do
    allow(Manpages::GemVersion).to receive(:new).and_return(instance_double(Manpages::GemVersion, latest?: false))
    FileUtils.ln_s("spec/data/man/example.1", "spec/tmp/man/man1/example.1")
    described_class.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).uninstall_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to contain_exactly(
      "spec/tmp/man/man1",
      "spec/tmp/man/man1/example.1",
    )
  end
end
