# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-26
#
# Parser for ActivityRecord conversion from Trello data

require 'date'

require 'time_trello/activity_record'

module TimeTrello

  # Public: Parser for Trello::Action to ActivityRecord conversion. See
  # ruby-trello for Trello::Action class specification. 
  class Parser
    # Private: Prefix to use in detecting if a given comment is really an
    # expected one
    private
    attr :prefix

    # Private: Class variable used to hold the workflow pieces that parses the
    # Trello::Action into TimeTrello::ActivityRecord. Each workflow step is a
    # block that takes two parameters:
    #
    # action_record - Hash containing Trello::Action and Trello::Member instances
    # record - TimeTrello::ActivityRecord instance to build
    #
    # Return:: true if parsing was flawless and false otherwise
    #
    protected
    def workflow
      [
        # Detects if a given action_record is the one we are looking for.
        lambda do |action_record, activity|
          return action_record[:action].data['text'].starts_with?(@prefix) unless action_record[:action].data['text'] == nil

          false
        end,
        
        # Parses the duration
        lambda do |action_record, activity|
          txt_duration = action_record[:action].data['text'].scan(/[0-9]+:[0-9]+/)
          activity.duration = Duration.new(txt_duration[0]) unless txt_duration.size == 0

          !activity.duration.nil?
        end,

        # Parses the comment owner 
        lambda do |action_record, activity|
          activity.owner = action_record[:member].full_name

          !activity.owner.nil?
        end,

        # Parses the project
        lambda do |action_record, activity|
          activity.project = action_record[:action].data["board"]["name"]

          !activity.project.nil?
        end,

        # Parses the start date
        lambda do |action_record, activity|
          activity.start_date = action_record[:action].date
          txt_date = action_record[:action].data["text"].scan(/\[[A-Z0-9:. -]+\]/)
          activity.start_date = DateTime.parse(txt_date[0].to_s).to_time unless txt_date.size == 0

          !activity.start_date.nil?
        end,

        # Parses the task comment
        lambda do |action_record, activity|
          txt_comment = action_record[:action].data["text"].scan(/"[a-zA-Z0-9]+"/)
          if txt_comment.size != 0
            activity.task_description = txt_comment[0]
          else
            activity.task_description  = action_record[:action].card.name
          end

          !activity.task_description.nil?
        end,

        # Parses the task id
        lambda do |action_record, activity|
          activity.id = action_record[:action].id

          !activity.id.nil?
        end
      ]
    end
    
    # Public: Initializes the parser, setting it to the proper state.
    #
    # action_record - Hash containing the following elements:
    #          - :action_record - An instance of Trello::Action_Record class
    #          - :member - An instance of Trello::Member class, which is the
    #            creator of the action_record with details.
    # prefix - Prefix to use for comment detection
    public
    def initialize(prefix)
      @prefix = prefix
    end

    # Public: Parses the action_record, building an instance of ActivityRecord. This
    # parser is based on a workflow defined by a constant array of blocks. Each
    # block is a step that will be executed in sequence.
    def parse(action_record)
      parsed_record = ActivityRecord.new()

      for step in self.workflow
        if !step.call(action_record, parsed_record)
          # Workflow was interrupted. Not necessarily an error. Possibly the
          # action_record was not the one we are looking for.
          return nil
        end
      end

      parsed_record
    end
    
  end

end
