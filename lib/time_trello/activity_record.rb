# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Defines the structure that holds the activity record grabbed from a trello
# board.

require 'time_trello/duration';

module TimeTrello
  
  # Public: An activity record identifies completely an activity done in
  # trello. Its main ideia is to be a standard record that can be compared,
  # sorted and collected, used for reporting purposes.
  class ActivityRecord
    include Comparable

    # Public: Task duration
    attr :duration
    # Public: Task owner
    attr :owner
    # Public: Project name (i.e., Trello board)
    attr :project
    # Public: Task start date
    attr :start_date

    # Public: Initializes this class with proper information about a given task
    #
    # project - Project name (i.e., the board name)
    #
    # owner - Name of the duration owner
    #
    # start_date - When the task started
    #
    # duration - The task duration
    def initialize(*args)
      if args.size != 0
        @duration   = args[0]
        @owner      = args[1]
        @project    = args[2]
        @start_date = args[3]
      end
    end

    # Public: Implementation of Comparable mixin
    #
    # other - The other instance of ActivityRecord to compare with.
    #
    # This method compares two instances of ActivityRecord hierachly.
    def <=>(other)
      result = @project <=> other.project
      result = @owner <=> other.owner if result == 0
      result = @start_date <=> other.start_date if result == 0
      
      result
    end
  end

end


