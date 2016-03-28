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

    
    # Public: Initializes this class with hours, minutes and seconds. You can
    # provide two different sets of arguments in order to initialize this class.
    #
    # hours - Hours as an integer.
    #
    # minutes - Minutes as an integer using sexagesimal representation.
    #
    # seconds - Seconds as an integer, using sexagesimal representation.
    #
    # or:
    #
    # a string containing the duration using the format hh:mm.ss
    public
    def initialize(*args)
      @internal_seconds = 0 
      time_components = args
      if args.size == 1 && args[0].class.equal?(String)
        time_components = args[0].split(/[:.]/)
      end
      factor = 3600
      time_components.each do |component|
        @internal_seconds += factor * component.to_i
        factor /= 60
      end
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

    # Public: Getter. Returns the number of raw minutes of a given duration
    #
    # Important: This is a float value, since it is a raw value
    def raw_minutes
      @internal_seconds.abs.to_f / 60.0
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
    #
    # Important: The resultant duration will have its components described
    # always as positive numbers, even if other is greater than this
    # instance. It is because the way ruby operates over negative numbers in an
    # integer division.
    def -(other)
      duration = Duration.new(0)
      duration.internal_seconds = @internal_seconds - other.internal_seconds

      duration
    end
  end

end
