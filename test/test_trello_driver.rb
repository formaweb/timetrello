# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Test scenarios for Duration tests

require 'Trello'
require 'minitest/autorun'
require 'time_trello/trello_driver'

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
    trello_driver = TrelloDriver.new(@board_id, ':clock12:')
    trello_driver.activities.each do |activity|
      puts "Activity: #{activity}"
    end
  end

end
