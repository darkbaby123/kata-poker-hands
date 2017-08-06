module PokerHands
  class Card
    VALUES = %w(A K Q J T 9 8 7 6 5 4 3 2).freeze

    attr_reader :value, :suit

    def initialize(str)
      @value = str[0]
      @suit = str[1]
    end

    def <=>(other)
      other.value_idx <=> value_idx
      # re = value <=> other.value
      # re == 0 ? suit <=> other.suit : re
    end

    def value_idx
      @value_idx ||= VALUES.index(value)
    end

    def self.to_proc
      method(:new).to_proc
    end
  end
end
