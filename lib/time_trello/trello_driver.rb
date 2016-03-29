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
require 'time_trello/parser'

module TimeTrello

  # Public: Driver responsible to convert data gathered from Trello to an
  # internal representation.
  class TrelloDriver
    attr_accessor :board_id
    attr_accessor :prefix

    def initialize(board_id, prefix)
      @board_id = board_id
      @prefix = prefix
      @activities = []
      @board = nil
    end

    # Public: Getter. Gets a board, based on a board id.
    def board
      @board = Trello::Board.find(@board_id) if @board == nil

      @board
    end

    # Public: Getter. Gets all activities for a given board.
    def activities
      return @activities if @activities != nil && @activities.length > 0
      
      @activities = []
      self.board.cards.each do |card|
        card.actions.each do |action|
          member = Trello::Member.find(action.member_creator_id)
          action_record = {action: action, member: member}
          activity = (Parser.new(action_record, @prefix)).parse
          @activities.push(activity) unless activity == nil
        end
      end
      
      @activities
    end

  end
end
