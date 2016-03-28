# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Main gem module

require 'trello'

require 'time_trello/version'
require 'time_trello/report'
require 'time_trello/duration'

module TimeTrello
  # Private: Prefix for comment detection/parsing
  private
  attr_accessor :prefix

  # Public: Initializes this module with the proper trello client configuration.
  #
  # public_key - Trello public key used for authentication.
  # member_token - Trello member token, used for authentication.
  public
  def self.initialize(public_key, member_token, prefix = ':clock12:')
    @prefix = prefix
    Trello.configure do |config|
      config.developer_public_key = public_key
      config.member_token = member_token
    end
  end

  # Public: Generates the report based on the provided parameters.
  #
  # start_date - The start date to limit the results.
  # end_date - The end date to limit the results.
  # board_id - Identification of the board that should be parsed in order to
  #            return results.
  # filter - A block containing a filter for the results. The block must receive
  #          a parameter which is an instance of ActivityRecord.
  def self.find_all(start_date, end_date, board_id, &filter)
    (Report.new(start_date, end_date, board_id, @prefix)).find_all(&filter)
  end
  
end
