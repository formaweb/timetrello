# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-22
#
# Trello driver, used to access trello and convert records to an internal
# representation

require 'trello'
require 'time_trello/activity_record'

module TimeTrello

  # Public: Driver responsible to convert data gathered from Trello to an
  # internal representation.
  class TrelloDriver
    attr :board
    attr :activities
    attr_accessor :board_id
    attr_accessor :prefix

    def initialize(board_id, prefix)
      @board_id = board_id
      @prefix = prefix
    end

    # Public: Getter. Gets a board, based on a board id.
    def board
      @board = Trello::Board.find(board_id) unless @board == nil

      @board
    end

    # Public: Getter. Gets all activities for a given board.
    def activities
      return @activities if @activities != nil && @activities.length > 0

      @activities = []
      @board.cards.each do |card|
        if card.has_actions
          card.actions.each do |action|
            activity = parse_activity(action)
            @activities.push(activity) unless activity == nil
          end
        end
      end

      @activities
    end

    # Private: Parses an action in order to construct an ActivityRecord instance
    #
    # action - Action related to a given card
    def parse_activity(action)
      puts "Action is #{action}"
    end
   end
end
