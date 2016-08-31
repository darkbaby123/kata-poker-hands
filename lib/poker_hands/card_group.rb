module PokerHands
  class CardGroup
    attr_reader :value, :count, :cards

    def initialize(value, count, cards)
      @value, @count, @cards = value, count, cards
    end
  end
end
