# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Reporting engine. Used to select and build a result set to the caller.

require 'time_trello/trello_driver'

module TimeTrello

  # Public: This class represents a report manager on the time trello
  # structure. It coordinates efforts with the persistence manager in order to
  # collect data from a given trello board.
  class Report
    # Private: Getter for trello driver.
    protected
    def driver
      @driver = TrelloDriver.new(@board_id, @prefix) if @driver == nil

      @driver
    end
    
    # Public: Prefix for proper filtering
    public
    attr_accessor :prefix
    # Public: Report start date
    attr_accessor :start_date
    # Public: Report end date
    attr_accessor :end_date
    # Public: board identification for reporting
    attr_accessor :board_id

    # Public: Initializes this class providing initial filter information
    #
    # start_date - Used to limit the result set. It is the start of time records
    # end_date - Used to limit the result set. It is the end of time records
    # board_id - Identification of the given board. Used to grab information
    # from an specific board.
    def initialize(start_date, end_date, board_id, prefix)
      @start_date = start_date
      @end_date = end_date
      @board_id = board_id
      @prefix = prefix
    end

    # Public: Generates the report based on a filter, if provided. The filter is
    # a block that will filter the result set accordingly. The result set is
    # always an array containing instances of ActivityRecord. See::
    # ActivityRecord
    #
    # filter - Block used to filter the result set even further. It must follow
    # the same format for the block passed as parameter to Array.find_all
    # method. Each element on the array is, in fact, an instance of
    # TimeTrello::ActivityRecord
    def find_all &filter
      result_set = self.driver.activities.find_all { |activity| activity.start_date >= @start_date && activity.start_date <= @end_date }

      if filter
        return result_set.find_all &filter  
      end

      result_set
    end

    # Public: Setter. Overrides the board_id setter in order to initialize the
    # driver properly
    def board_id=(board_id)
      if board_id != @board_id
        @board_id = board_id
        self.driver.reset_cache
        puts "Driver reset"
      end
    end
    
  end
end
