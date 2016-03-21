# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Defines the structure that holds the activity record grabbed from a trello
# board.
module TimeTrello
  # An activity record identifies completely an activity done in trello. Its
  # main ideia is to be a standard record that can be compared, sorted and
  # collected, used for reporting.
  class ActivityRecord
    include Comparable
    attr :duration
    attr :owner
    attr :project 
    attr :start_time
    def initialize project, owner, start_time, duration
      @duration = duration
      @owner = owner
      @project = project
      @start_time = start_time
    end
    def <=>(y)
      r = @project <=> y.project
      if r == 0 
        r = r || @owner <=> y.owner
      end
      r
    end
  end
end

require 'timetrello/duration';
