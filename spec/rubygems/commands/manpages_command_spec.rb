require 'spec_helper'
require 'rubygems/command_manager'
require 'rubygems/mock_gem_ui'

require_relative '../../../lib/rubygems/commands/manpages_command'

describe Gem::Commands::ManpagesCommand do
  include Gem::DefaultUserInteraction

  subject { Gem::Commands::ManpagesCommand.new }

  it 'executes' do
    subject.handle_options %w[here goes you params]

    ui = Gem::MockGemUi.new
    use_ui(ui) do
      subject.execute
    end

    expect(ui.output).to eq "It works!\n"
  end

end
