module PokerHands
  module Comparer
    class << self
      def vs(left, right)
        [
          :straight_flush,
          :four_of_a_kind,
          :full_house,
          :flush,
          :straight,
          :three_of_a_kind,
          :two_pairs,
          :pair,
          :high_card,
        ].each do |rule|
          left_match = send("#{rule}?", left)
          right_match = send("#{rule}?", right)

          if left_match && right_match
            return send("vs_#{rule}", left, right)
          elsif left_match
            return 1
          elsif right_match
            return -1
          end
        end
      end

      def straight_flush?(hand)
        straight?(hand) && flush?(hand)
      end

      def straight?(hand)
        Card::VALUES.join.include?(hand.cards.map(&:value).join)
      end

      def flush?(hand)
        hand.cards.map(&:suit).uniq.size == 1
      end

      def four_of_a_kind?(hand)
        hand.groups[0].count == 4
      end

      def full_house?(hand)
        three_of_a_kind?(hand) && hand.groups[1].count == 2
      end

      def three_of_a_kind?(hand)
        hand.groups[0].count == 3
      end

      def two_pairs?(hand)
        pair?(hand) && hand.groups[1].count == 2
      end

      def pair?(hand)
        hand.groups[0].count == 2
      end

      def high_card?(hand)
        true
      end

      def vs_four_of_a_kind(left, right)
        left.groups[0].value <=> right.groups[0].value
      end

      def vs_full_house(left, right)
        left.groups[0].value <=> right.groups[0].value
      end

      def vs_flush(left, right)
        left.cards.each_with_index do |lc, i|
          re = compare_card_values(lc, right.cards[i])
          if re == 0
            next
          else
            return re
          end
        end
        0
      end

      def vs_straight(left, right)
        compare_card_values(left.cards[0], right.cards[0])
      end

      def vs_three_of_a_kind(left, right)
        compare_card_values(left.groups[0].cards[0], right.groups[0].cards[0])
      end

      alias_method :vs_straight_flush, :vs_straight

      def vs_card_groups(left, right)
        left.groups.each_with_index do |lg, i|
          re = compare_card_values(lg.cards[0], right.groups[i].cards[0])
          if re == 0
            next
          else
            return re
          end
        end
        0
      end

      def compare_card_values(left_card, right_card)
        right_card.value_idx <=> left_card.value_idx
      end

      alias_method :vs_two_pairs, :vs_card_groups
      alias_method :vs_pair,      :vs_card_groups
      alias_method :vs_high_card, :vs_card_groups
    end
  end
end
