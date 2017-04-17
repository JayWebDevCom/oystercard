require 'station'

describe Station do

let(:station) { described_class.new(:aldgate, 3) }

describe 'Initialization' do

  it 'should have correct name' do
    expect(station.name).to eq :aldgate
  end

  it 'should have a corrct zone' do
    expect(station.zone).to eq 3
  end
 end
end
