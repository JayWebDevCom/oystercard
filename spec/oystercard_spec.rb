require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe 'Initialization' do

      it 'has default balance of 0' do
        expect(oystercard.balance).to eq 0
      end

  end

  describe 'Top Up' do

    it 'changes balance' do
      oystercard.top_up(20)
      expect(oystercard.balance).to eq 20
    end

  end

end
