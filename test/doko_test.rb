require "test_helper"
#require './main'

class DokoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Doko::VERSION
  end

  def capture_stdout
    $stdout = StringIO.new
    yield
    output = $stdout.string
    $stdout = STDOUT
    eval(output)
  end

  def test_has_no_args
    output = capture_stdout { "1234".doko.to_i }
    assert_equal 'to_i',   output[:method_name]
    assert_equal 'String', output[:reciever_class]
    assert_equal [], output[:args]
  end

  def test_has_args
    output = capture_stdout { "1,2".doko.split(',') }
    assert_equal 'split', output[:method_name]
    assert_equal 'String', output[:reciever_class]
    assert_equal [','], output[:args]
  end

  def test_no_call_method
    output =  "1,2".doko
    assert_equal output.class, Doko::Proxy
  end
end
