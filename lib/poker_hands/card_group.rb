module PokerHands
  class CardGroup
    attr_reader :value, :count, :cards

    def initialize(value, count, cards)
      @value = value
      @count = count
      @cards = cards
    end
  end
end
