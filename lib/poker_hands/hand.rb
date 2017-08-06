module PokerHands
  class Hand
    attr_reader :cards, :groups

    def initialize(cards_str)
      @cards = cards_str.split(' ').map(&Card).sort { |a, b| b <=> a }
      generate_groups
    end

    def generate_groups
      group_hsh = cards.each_with_object({}) do |card, re|
        group = re[card.value] ||= { count: 0, cards: [] }
        group[:count] += 1
        group[:cards] << card
        re
      end

      @groups = group_hsh.to_a.map do |value, data|
        CardGroup.new(value, data[:count], data[:cards])
      end.sort do |a, b|
        re = b.count <=> a.count
        re.zero? ? b.value <=> a.value : re
      end
    end
  end
end
