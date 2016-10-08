require 'spec_helper'
require 'fileutils'

describe Manpages::Uninstall do

  before :each do
    FileUtils.mkdir_p("spec/tmp/man/man1")
  end

  it 'Deletes a manpage if the link is to this gem' do
    FileUtils.ln_s("spec/data/man/example.1", "spec/tmp/man/man1/example.1")
    Manpages::Uninstall.new(
      "spec/data",
      "spec/tmp/man"
    ).uninstall_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array ["spec/tmp/man/man1"]
  end

  it 'Does not delete a manpage if it does not link to this gem' do
    FileUtils.ln_s("README.md", "spec/tmp/man/man1/example.1")
    Manpages::Uninstall.new(
      "spec/non_existent",
      "spec/tmp/man"
    ).uninstall_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array [
      "spec/tmp/man/man1",
      "spec/tmp/man/man1/example.1"
    ]
  end

end
