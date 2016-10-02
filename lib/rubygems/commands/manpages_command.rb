class Gem::Commands::ManpagesCommand < Gem::Command
  def initialize
    super("manpages", "Add a description here")
  end

  def execute
    # TODO: Add command to install
    #   to rbenv and rvm


    # here goes the code that will be executed
    # when someone runs "gem manpages"
    say "It works!"
  end
end
