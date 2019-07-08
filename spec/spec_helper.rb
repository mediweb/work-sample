require "byebug"
require "capybara"
require "capybara/dsl"

RSpec.configure do |config|
 config.include Capybara::DSL
end
