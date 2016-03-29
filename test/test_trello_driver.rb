# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Test scenarios for Trello Driver

require 'minitest/autorun'
require 'timetrello/trello_driver'

class TestTrelloDriver < Minitest::Test
  attr_accessor :board_id
  
  def setup
    Trello.configure do |config|
      config.developer_public_key = ENV['PUBLIC_KEY']
      config.member_token = ENV['MEMBER_TOKEN']
    end
    @board_id = ENV['BOARD_ID']
  end
  
  # Public: Basic test against a trello board
  def test_basic_scenario
    trello_driver = TimeTrello::TrelloDriver.new(@board_id, ':clock12:')
    trello_driver.activities.each do |activity|
      assert(activity.project != nil, "Invalid project name")
      assert(activity.start_date != nil, "Invalid start date")
      assert(activity.duration != nil, "Invalid duration")
      assert(activity.owner != nil, "Invalid owner")
    end
  end

end
