# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Test scenarios for Duration tests

require 'minitest/autorun'
require 'timetrello/duration'

class TestDuration < Minitest::Test

  # Public: Tests a duration with basic evaluation
  def test_basic_duration
    duration = TimeTrello::Duration.new(10, 20, 30) # 10:20.30
    assert_equal(10, duration.hours)
    assert_equal(20, duration.minutes)
    assert_equal(30, duration.seconds)
  end

  # Public: Test scenario: duration summing
  def test_duration_sum
    x = TimeTrello::Duration.new(10, 20, 30)
    y = TimeTrello::Duration.new(30, 20, 10)
    r = x + y
    assert_equal(40, r.hours)
    assert_equal(40, r.minutes)
    assert_equal(40, r.seconds)
  end

  # Public: Test scenario: checks subtraction operations
  def test_duration_subtraction
    x = TimeTrello::Duration.new(40, 40, 40)
    y = TimeTrello::Duration.new(10, 10, 10)
    r = x - y
    assert_equal(30, r.hours)
    assert_equal(30, r.minutes)
    assert_equal(30, r.seconds)
  end

  # Public: Test scenario: checks leaps over hours, minutes and seconds
  def test_clock_leap
    x = TimeTrello::Duration.new(30, 30, 30)
    y = TimeTrello::Duration.new(31, 0, 0)
    r = x - y
    assert_equal(0, r.hours)
    assert_equal(29, r.minutes)
    assert_equal(30, r.seconds)
  end

  # Public: Test scenario: tests duration against the new constructor
  def test_string_parameter
    x = TimeTrello::Duration.new("10:20.30")
    assert_equal(10, x.hours)
    assert_equal(20, x.minutes)
    assert_equal(30, x.seconds)
  end
  
end
