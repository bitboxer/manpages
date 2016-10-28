require 'spec_helper'
require 'fileutils'

describe Manpages::Install do

  it 'copies the man pages to a correct directory structure' do
    Manpages::Install.new(
      Gem::Specification.new(name: "manpages_test"),
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
      Gem::Specification.new(name: "manpages_test"),
      "spec/non_existent",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array []
  end

  it 'Does not install if version is too old' do
    expect_any_instance_of(Manpages::GemVersion).to receive(:is_latest?).and_return(false)
    Manpages::Install.new(
      Gem::Specification.new(name: "manpages_test"),
      "spec/data",
      "spec/tmp/man"
    ).install_manpages
    expect(Dir.glob("spec/tmp/man/**/*")).to match_array []
  end

end
