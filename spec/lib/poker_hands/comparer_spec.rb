RSpec.describe PokerHands::Comparer do
  subject { described_class.vs(left_hand, right_hand) }

  let(:left_hand) { create_hand(left) }
  let(:right_hand) { create_hand(right) }

  describe 'straight flush - one wins' do
    let(:left) { '3H 2H 6H 4H 5H' }
    let(:right) { '9D QD TD JD KD' }

    it { is_expected.to eq(-1) }
  end

  describe 'straight flush - equal' do
    let(:left) { '4H 9H 5H 8H 6H' }
    let(:right) { '4D 9D 5D 8D 6D' }

    it { is_expected.to eq 0 }
  end

  describe 'four of a kind - one wins' do
    let(:left) { '5D 5D 5H 5S 9C' }
    let(:right) { '6D 6D 6H 6S 3C' }

    it { is_expected.to eq(-1) }
  end

  describe 'four of a kind - equal' do
    let(:left) { '5D 5D 5H 5S 9C' }
    let(:right) { '5D 5D 5H 5S KC' }

    it { is_expected.to eq 0 }
  end

  describe 'full house - one wins' do
    let(:left) { '5D 5D 5H 6S 6C'  }
    let(:right) { 'JD JD JH 5S 5C' }

    it { is_expected.to eq(-1) }
  end

  describe 'full house - equal' do
    let(:left) { 'JD JD JH 6S 6C' }
    let(:right) { 'JD JD JH 5S 5C' }

    it { is_expected.to eq 0 }
  end

  describe 'flush - one wins' do
    let(:left) { '8D 8D 3D JD KD' }
    let(:right) { '9H 9H 9H QH 5H' }

    it { is_expected.to eq 1 }
  end

  describe 'flush - equal' do
    let(:left) { '9D 4D 6D KD AD' }
    let(:right) { '9H 6H 4H KH AH' }

    it { is_expected.to eq 0 }
  end

  describe 'straight - one wins' do
    let(:left) { 'TD JH QH KS AD' }
    let(:right) { '9S TD JH QH KS' }

    it { is_expected.to eq 1 }
  end

  describe 'straight - equal' do
    let(:left) { 'TD JH QH KS AD' }
    let(:right) { 'TH JH QC KD AS' }

    it { is_expected.to eq 0 }
  end

  describe 'three of a kind - one wins' do
    let(:left) { 'TD TD TH 5C 8C' }
    let(:right) { '9S 9S 9C TD QC' }

    it { is_expected.to eq 1 }
  end

  describe 'three of a kind - equal' do
    let(:left) { 'TD TD TH 5C 8C' }
    let(:right) { 'TD TD TH 6C 9C' }

    it { is_expected.to eq 0 }
  end

  describe 'two pairs - one wins' do
    let(:left) { 'KD KC 8H 8C 9C' }
    let(:right) { 'TD TC 9H 9C 8C' }

    it { is_expected.to eq 1 }
  end

  describe 'two pairs - one wins' do
    let(:left) { 'KD KC 8H 8C 9C' }
    let(:right) { 'KD KC 7H 7C AS' }

    it { is_expected.to eq 1 }
  end

  describe 'two pairs - equal' do
    let(:left) { 'KD KC 8H 8C 9C' }
    let(:right) { 'KC KS 8D 8H 9S' }

    it { is_expected.to eq 0 }
  end

  describe 'pair - one wins' do
    let(:left) { 'QS 8H QD 5C 9C' }
    let(:right) { 'KD TH TS AH 9S' }

    it { is_expected.to eq 1 }
  end

  describe 'pair - one wins' do
    let(:left) { 'QS 8H QD AC 9C' }
    let(:right) { 'KD QH QS 5H 9S' }

    it { is_expected.to eq 1 }
  end

  describe 'pair - equal' do
    let(:left) { 'QS 8H QD AC 9C' }
    let(:right) { '8D QH QS AH 9S' }

    it { is_expected.to eq 0 }
  end

  describe 'high card - one win' do
    let(:left) { '5S 8H KD TC 9C' }
    let(:right) { 'KD 4H TS 5H 8S' }

    it { is_expected.to eq 1 }
  end

  describe 'high card - equal' do
    let(:left) { '5S 8H KD TC 9C' }
    let(:right) { 'KD 5H TS 9H 8S' }

    it { is_expected.to eq 0 }
  end

  describe 'full house vs flush - left wins' do
    let(:left) { '2S 4S 4S 2S 4S' }
    let(:right) { '2S 8S AS QS 3S' }

    it { is_expected.to eq 1 }
  end

  describe 'straight flush vs four of a kind - left wins' do
    let(:left) { '2S 3S 4S 5S 6S' }
    let(:right) { 'KS KD KS KC AC' }

    it { is_expected.to eq 1 }
  end

  def create_hand(str)
    PokerHands::Hand.new(str)
  end
end
