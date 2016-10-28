require 'spec_helper'
require 'fileutils'

describe Manpages::Uninstall do

  before :each do
    FileUtils.mkdir_p("spec/tmp/man/man1")
  end

  it 'Deletes a manpage if the link is to this gem' do
    FileUtils.ln_s("spec/data/man/example.1", "spec/tmp/man/man1/example.1")
    Manpages::Uninstall.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).uninstall_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array ["spec/tmp/man/man1"]
  end

  it 'Does not delete a manpage if it does not link to this gem' do
    FileUtils.ln_s("README.md", "spec/tmp/man/man1/example.1")
    Manpages::Uninstall.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/non_existent",
      "spec/tmp/man"
    ).uninstall_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array [
      "spec/tmp/man/man1",
      "spec/tmp/man/man1/example.1"
    ]
  end

  it 'Does not uninstall if version is too old' do
    expect_any_instance_of(Manpages::GemVersion).to receive(:is_latest?).and_return(false)
    FileUtils.ln_s("spec/data/man/example.1", "spec/tmp/man/man1/example.1")
    Manpages::Uninstall.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).uninstall_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array [
      "spec/tmp/man/man1",
      "spec/tmp/man/man1/example.1"
    ]
  end

end
