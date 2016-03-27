# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-26
#
# Parser for ActivityRecord conversion from Trello data

require 'time_trello/activity_record'

module TimeTrello

  # Public: Parser for action to ActivityRecord conversion. See ruby-trello for
  # Action class specification. This class is part of TrelloDriver class.
  class Parser
    # Private: Instance of Action to analize
    private
    attr :action

    # Private: Prefix to use in detecting if a given comment is really an
    # expected one
    attr :prefix

    # Private: Class variable used to hold the workflow pieces that parses the
    # Trello::Action into TimeTrello::ActivityRecord. Each workflow step is a
    # block that takes two parameters:
    #
    # action - Trello::Action instance to parse
    #
    # record - TimeTrello::ActivityRecord instance to build
    #
    # Return:: true if parsing was flawless and false otherwise
    #
    @workflow = [
      # Detects if a given action is the one we are looking for.
      lambda { |action, record| return action.data['text'].starts_with?(@prefix) },
      
      # Parses the duration
      lambda do |action, record|
        txt_duration = action.data['text'].scan(/[0-9]+:[0-9]+/)
        txt_duration = action.data
      end
    ]
    
    # Private: List of steps that parses the action, loading fields of a
    # provided ActivityRecord instance. It is used as a workflow.

    # Public: Initializes the parser, setting it to the proper state.
    #
    # action - Instance of Trello::Action that will be analized and parsed.
    #
    # prefix - Prefix to use for comment detection
    public
    def initialize(action, prefix)
      @action = action
      @prefix = prefix
    end

    # Public: Parses the action, building an instance of ActivityRecord. This
    # parser is based on a workflow defined by a constant array of blocks. Each
    # block is a step that will be executed in sequence.
    def parse
      record = ActivityRecord.new()

      for step in self::workflow
        if !step(@action, record)
          # Workflow was interrupted. Not necessarily an error. Possibly the
          # action was not the one we are looking for.
          return nil
        end
      end

      record
    end
    
  end

end
