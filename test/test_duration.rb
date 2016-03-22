# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Test scenarios for Duration tests

require 'minitest/autorun'
require 'timetrello/duration'

class DurationTest < Minitest::Test

  def test_basic_duration
    duration = TimeTrello::Duration.new(10, 20, 30) # 10:20.30
    assert_equal(duration.hours, 10)
    assert_equal(duration.minutes, 20)
    assert_equal(duration.seconds, 30)
  end
end
