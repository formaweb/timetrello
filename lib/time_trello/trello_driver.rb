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
      @activities = nil
      @board = nil
      @members = nil
      @parser = nil
    end

    # Public: Getter. Returns a record parser instance
    def parser
      @parser = Parser.new(@prefix) if @parser.nil?

      @parser
    end
    
    # Public: Getter. Gets a board, based on a board id.
    def board
      retried = false

      begin
        @board = Trello::Board.find(@board_id) if @board.nil? 
      rescue
        if !retried
          retried = true
          retry
        else
          raise "Failed to connect to Trello API"
        end 
      end

      @board
    end

    # Public: Getter. Gets all members subscribed to the board under analysis
    def members
      retried = false

      begin
        @members = self.board.members if @members.nil?
      rescue
        if !retried
          retried = true
          retry
        else
          raise "Failed to connect to Trello API"
        end
      end
      
      @members
    end

    # Public: Getter. Gets all activities for a given board.
    def activities
      return @activities if !@activities.nil? && @activities.length > 0
      
      @activities = []
      self.board.cards.each do |card|
        card.actions.each do |action|
          member = self.members.select { |member| member.id == action.member_creator_id }.first
          action_record = {action: action, member: member}
          activity = self.parser.parse(action_record)
          @activities.push(activity) unless activity.nil?
        end
      end
      
      @activities
    end

    # Public: Resets the driver caches
    def reset_cache
      @activities = nil
      @board = nil
      @members = nil
    end
  end
end
