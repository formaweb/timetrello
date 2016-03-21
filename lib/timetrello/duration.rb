# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Describes a duration in hours and minutes and proper operations using those.

module TimeTrello
  # Describes a duration in terms of hours and minutes, representing data
  # internaly as seconds.
  class Duration
    attr_accessor :seconds
    def initialize hours, minutes=0, seconds=0
      @seconds = hours * 3600 + minutes * 60 + seconds
    end
    def hours
      @seconds / 3600
    end
    def minutes
      @seconds / 60
    end
    def +(y)
      Duration.new 0, 0, @seconds + y.seconds
    end
    def -(y)
      Duration.new 0, 0, @seconds - y.seconds
    end
  end
end
