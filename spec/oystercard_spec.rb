require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe 'Initialization' do

      it 'has default balance of 0' do
        expect(oystercard.balance).to eq described_class::DEFAULT_BALANCE
      end

  end

  describe 'deduct' do
    it 'should reduce balance' do
      oystercard.top_up(40)
      expect{ oystercard.deduct 10}.to change{ oystercard.balance }.by -10
    end
  end

  describe 'Top Up' do

    it 'should increase balance' do
      expect{ oystercard.top_up 10}.to change{ oystercard.balance }.by +10
    end

    it 'can not exceed balance limit' do
      oystercard.top_up(50)
      expect { oystercard.top_up(41)}.to raise_error 'can not exceed limit'
    end

  end

end
