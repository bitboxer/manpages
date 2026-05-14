# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "manpages"
require "pry"

require_relative "../lib/manpages"

RSpec.configure do |config|
  config.before do
    FileUtils.mkdir_p("spec/tmp")
  end

  config.after do
    FileUtils.rm_rf("spec/tmp")
  end
end
