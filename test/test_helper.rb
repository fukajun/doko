$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "doko"

require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!

