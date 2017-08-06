require_relative 'poker_hands/card'
require_relative 'poker_hands/card_group'
require_relative 'poker_hands/comparer'
require_relative 'poker_hands/hand'

module PokerHands
  def self.vs(left, right)
    re = Comparer.vs(Hand.new(left), Hand.new(right))
    case re
    when 0 then 'Tie.'
    when 1 then 'Left wins.'
    else 'Right wins.'
    end
  end
end
