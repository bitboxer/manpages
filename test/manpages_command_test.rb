require 'minitest/autorun'
require 'rubygems/command_manager'
require 'rubygems/test_case'

require_relative '../lib/rubygems/commands/manpages_command'

class ManpagesCommandTest < Gem::TestCase
  def setup
    super
    @cmd = Gem::Commands::ManpagesCommand.new
  end

  def test_execute
    @cmd.handle_options %w[here goes you params]

    ui = Gem::MockGemUi.new
    use_ui(ui) do
      @cmd.execute
    end

    assert_equal "It works!\n", ui.output
  end
end
