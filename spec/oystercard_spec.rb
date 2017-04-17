require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe 'Initialization' do

      it 'has default balance of 0' do
        expect(oystercard.balance).to eq described_class::DEFAULT_BALANCE
      end

      it 'has default status of unused' do
        expect(oystercard.status).to eq :unused
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

  describe 'touch in / touch out' do

    before do
       oystercard.top_up(Oystercard::MINIMUM_BALANCE)
    end

    it 'updates status to :in_use' do
      oystercard.touch_in
      expect(oystercard.status).to eq :in_use
    end

    it 'updates status to :not_in_use' do
      oystercard.touch_out
      expect(oystercard.status).to eq :not_in_use
    end


  end

  describe 'MINIMUM_BALANCE' do

    it  'cannot be used with balance less than MINIMUM_BALANCE' do
      message = "Insufficuent funds"
      expect { oystercard.touch_in }.to raise_error message
    end

  end

  describe 'journey?' do

    it 'returns true when card status is :in_use' do
      oystercard.top_up(5)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    it 'returns false when card status is :not_in_use' do
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

  end

end
