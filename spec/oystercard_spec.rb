require 'oystercard'

describe Oystercard do
  it 'allows the user to create an instance of Oystercard' do
    is_expected.to be_instance_of Oystercard
  end

  it { is_expected.to respond_to :balance }
  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#balance' do
    it 'returns a default balance of zero' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'increases the balance by top_up amount' do
      expect{ subject.top_up(5) }.to change { subject.balance }.by 5 
    end

    it 'raises an error when overriding maximum balance' do
      max_value = Oystercard::MAXIMUM_LIMIT
      subject.top_up(max_value)
      expect{ subject.top_up 1 }.to raise_error "Maximum limit of #{ :MAXIMUM_LIMIT } reached"
    end
  end
  
  it { is_expected.to respond_to(:deduct).with(1).argument }

  describe '#deduct' do
    it 'reduces de balance' do
      expect{ subject.deduct 5 }.to change{ subject.balance }.by -5
    end
  end
   
  it { is_expected.to respond_to(:touch_in) }

  it 'returns true when card touches in' do
    expect(subject.touch_in).to be true 
  end 
  
  it { is_expected.to respond_to(:touch_out) }

  it 'returns true when card touches out' do
    expect(subject.touch_out).to be false
  end

  it { is_expected.to respond_to(:in_journey?) }

  it 'returns true for in journey when card is touched in' do
    subject.touch_in
    expect(subject.in_journey?).to eq true
  end

  it 'returns true for in journey when card is not touched out' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end 
  # when checking the card state shoud return in use if didn't touch out
end
