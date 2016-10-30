$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "manpages"
require "pry"

require_relative "../lib/manpages"

RSpec.configure do |config|
  config.before(:each) do
    FileUtils.mkdir_p("spec/tmp")
  end

  config.after(:each) do
    FileUtils.rm_rf("spec/tmp")
  end
end
