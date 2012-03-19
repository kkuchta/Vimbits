require 'test_helper'

class BitsHelperTest < ActionView::TestCase
  def test_limit_string_handles_special_line_endings
    limited_string = limit_string("test\r\n")
    assert_no_match /\.\.\./, limited_string
  end
end
