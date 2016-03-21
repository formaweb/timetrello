# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Reporting engine. Used to select and build a result set to the caller.
module TimeTrello
  class Report
    attr :start_date
    attr :end_date
    attr :board_id
    attr :result_set
    def initialize start_date, end_date, board_id
      @start_date = start_date
      @end_date = end_date
      @board_id = board_id
      @result_set = []
    end
    # Generates the report based on a filter, if provided. The filter is a block
    # that will filter the result set accordingly. The result set is always an
    # array containing instances of ActivityRecord.
    # See:: ActivityRecord 
    def generate &filter
      if @result_set.length > 0
        return @result_set
      end
      # TODO: Add calls to the persistence manager here
      if filter
        return @result_set.find_all &filter  
      end
      @result_set
    end
  end
end
