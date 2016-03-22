# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Describes a duration in hours and minutes and proper operations using those.

module TimeTrello

  # Public: Describes a duration in terms of hours and minutes, representing
  # data internaly as seconds.
  class Duration
    protected
    attr_accessor :internal_seconds # Internal representation of a duration

    public
    # Public: Initializes this class with hours, minutes and seconds.
    #
    # hours - Hours as an integer.
    #
    # minutes - Minutes as an integer using sexagesimal representation.
    #
    # seconds - Seconds as an integer, using sexagesimal representation.
    def initialize(hours, minutes = 0, seconds = 0)
      @internal_seconds = hours * 3600 + minutes * 60 + seconds
    end

    # Public: Getter. Returns the number of hours from a given duration
    def hours
      @internal_seconds.abs / 3600
    end

    # Public: Getter. Returns the number of minutes from the internal representation
    def minutes
      (@internal_seconds.abs / 60) % 60
    end

    # Public: Getter. Returns the number of seconds of a given duration
    def seconds
      @internal_seconds.abs % 60
    end

    # Public: Operator overload. Sums up two different instances of Duration
    #
    # other - The other operand
    def +(other)
      duration = Duration.new(0)
      duration.internal_seconds = @internal_seconds + other.internal_seconds

      duration
    end

    # Public: Operator overload. Subtracts two different instances of Duration.
    #
    # other - The other operand
    def -(other)
      duration = Duration.new(0)
      duration.internal_seconds = @internal_seconds - other.internal_seconds

      duration
    end
  end

end
