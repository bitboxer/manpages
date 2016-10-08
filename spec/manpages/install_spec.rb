require 'spec_helper'
require 'fileutils'

describe Manpages::Install do

  it 'copies the man pages to a correct directory structure' do
    Manpages::Install.new(
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array [
      "spec/tmp/man/man1",
      "spec/tmp/man/man1/example.1",
      "spec/tmp/man/man2",
      "spec/tmp/man/man2/example.2"
    ]
  end

  it 'ignores gems without a man dir' do
    Manpages::Install.new(
      "spec/non_existent",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array []
  end

end
