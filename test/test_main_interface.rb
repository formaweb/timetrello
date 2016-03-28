# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-28
#
# Test scenarios for the main gem interface

require 'trello'
require 'minitest/autorun'
require 'time_trello'

class TestTrelloMainInterface < Minitest::Test
  attr_accessor :board_id
  attr_accessor :public_key
  attr_accessor :member_token
  
  def setup
    @public_key = ENV['PUBLIC_KEY']
    @member_token = ENV['MEMBER_TOKEN']
    @board_id = ENV['BOARD_ID']
  end
  
  # Public: Basic test against
  def test_basic_scenario
    TimeTrello.initialize(@public_key, @member_token)
    activities = TimeTrello.find_all(Time.new(2012, 1, 1), Time.new(2016, 4, 1), @board_id)
    assert(activities.size > 0, "No activities found")
    puts "*** Test Results ***"
    puts "Found: #{activities.size} activities"
    duration = TimeTrello::Duration.new
    activities.each do |activity|
      duration = duration + activity.duration
    end
    puts "Total duration: #{duration.hours}:#{duration.minutes}"
  end

end
