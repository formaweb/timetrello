require 'date'
require 'trello'

require 'timetrello/version'

module TimeTrello

  def initialize public_key, member_token, prefix
    @prefix = prefix

    Trello.configure do |config|
      config.developer_public_key = public_key
      config.member_token = member_token
    end
  end

  def getTasks
    tasks = Array.new

    # Select Board
    board = Trello::Board.find(BOARD_ID)

    # Get Comments
    board.actions.each do |action|
      next unless action.type == 'commentCard'

      comment = action.data['text']
      next unless comment.start_with?(PREFIX)

      comment = /^(\d*:\d*)\s\[(.+)\]/.match(comment) # TODO: Need to be improved.

      card_name = action.card.name
      member = Trello::Member.find(action.member_creator_id).username

      tasks << {card_id: action.card.id, card_name: action.card.name}
    end

    tasks
  end

end
