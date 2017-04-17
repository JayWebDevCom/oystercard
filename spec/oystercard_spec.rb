require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe 'Initialization' do

      it 'has default balance of 0' do
        expect(oystercard.balance).to eq described_class::DEFAULT_BALANCE
      end

  end


  describe 'Top Up' do

    it 'changes balance' do
      oystercard.top_up(20)
      expect(oystercard.balance).to eq 20
    end

    it 'can not exceed balance limit' do
      oystercard.top_up(50)
      expect { oystercard.top_up(41)}.to raise_error 'can not exceed limit'
    end

  end

end
