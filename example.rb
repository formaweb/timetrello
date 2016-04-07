# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-29
#
# Example of a common usage of Time Trello gem

require 'time_trello'

public_key = ENV['PUBLIC_KEY']
member_token = ENV['MEMBER_TOKEN']

# Initializes the time trello sub-system, using the default prefix
TimeTrello.initialize(public_key, member_token)

# Get a list of items
activities = TimeTrello.find_all(Time.new(2012, 1, 1), Time.new(2016, 4, 1), ENV['BOARD_ID'])

puts "*** Activities within a date range ***"
activities.each { |activity| puts "Owner: #{activity.owner}\n\tDuration: #{activity.duration}\n\tTask: #{activity.task_description}\n\tCard Name:#{activity.card_name}" }

# You may want to get a filtered list of items:
activities = TimeTrello.find_all(Time.new(2012, 1, 1), Time.new(2016, 4, 1), ENV['BOARD_ID']) { |activity| activity.duration.hours > 1 }

puts "*** Filtered Activities ***"
activities.each { |activity| puts "Owner: #{activity.owner}\n\tDuration: #{activity.duration}\n\tTask: #{activity.task_description}\n\tCard Name:#{activity.card_name}" }
