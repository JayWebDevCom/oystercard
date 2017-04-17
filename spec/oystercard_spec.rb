require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) { double :station }

  describe 'Initialization' do
    it 'has default balance of 0' do
      expect(oystercard.balance).to eq described_class::DEFAULT_BALANCE
    end
  end

  describe '#top_up' do
    it 'should increase balance' do
      expect { oystercard.top_up 10 }.to change { oystercard.balance }.by +10
    end

    it 'can not exceed balance limit' do
      oystercard.top_up(50)
      expect { oystercard.top_up(41) }.to raise_error 'can not exceed limit'
    end
  end

  describe 'touch in / touch out' do
    before do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
    end

    it 'touching out deducts minimum fare' do
      amount = (-Oystercard::MINIMUM_BALANCE)
      expect { oystercard.touch_out }.to change { oystercard.balance }.by amount
    end

    it 'touching in should remember entry station' do
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

    it 'touching out should forget entry station' do
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end
  end

  describe 'MINIMUM_BALANCE' do
    it 'cannot be used with balance less than MINIMUM_BALANCE' do
      message = 'Insufficient funds'
      expect { oystercard.touch_in(station) }.to raise_error message
    end
  end

  describe '#journey?' do
    it 'true when card in touched in' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it 'false when touched out' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end
end
