# -*-ruby-*-
# Copyright (c) 2016 - Formaweb - All rights reserved
#
# Author:: Ronaldo Faria Lima
# Created:: 2016-03-21
#
# Main gem module
require 'date'
require 'trello'
require 'timetrello/version'

module TimeTrello
  def initialize public_key, member_token
    Trello.configure do |config|
      config.developer_public_key = public_key
      config.member_token = member_token
    end
  end
  def report start_date, end_date, board_id
    (Report.new start_date, end_date, board_id).generate
  end
end

require 'timetrello/report'
