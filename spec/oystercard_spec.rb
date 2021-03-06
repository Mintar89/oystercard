require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'allows the user to create an instance of Oystercard' do
    is_expected.to be_instance_of Oystercard
  end

  context '#balance' do
    it 'returns a default balance of zero' do
      expect(subject.balance).to eq 0
    end
  end

  context '#top_up' do
    it 'increases the balance by top_up amount' do
      expect{ subject.top_up(5) }.to change { subject.balance }.by 5 
    end

    it 'raises an error when overriding maximum balance' do
      max_value = Oystercard::MAXIMUM_LIMIT
      subject.top_up(max_value)
      expect{ subject.top_up 1 }.to raise_error "Maximum balance exceeded"
    end
  end
  
  context '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject.in_journey?).to eq nil
    end
  end 
  
  context '#touch_in' do
    it 'turns true when we touch in' do
      allow(subject).to receive(:min_fare?).and_return false
      subject.touch_in(station)
      expect(subject.in_journey?).to be_truthy
    end
    it 'raises an error when someone tries to touch in without min fare on card' do
      expect { subject.touch_in(station) }.to raise_error 'Insufficient funds, top up card'
    end
    it 'stores the value of entry station' do
      allow(subject).to receive(:min_fare?).and_return false
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end 
  
  context '#touch_out' do
    it 'turns when we touch out' do
      allow(subject).to receive(:min_fare?).and_return false
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq nil
    end
    it 'charges the minimum amount' do
      min_fare = Oystercard::MIN_FARE
      expect{ subject.touch_out(station) }.to change { subject.balance }.by -min_fare 
    end
    it { is_expected.to respond_to(:touch_out).with(1).argument }
  end 
  
  context '#list_of_previous_trips' do
    it 'returns the previous trips' do
      allow(subject).to receive(:min_fare?).and_return false
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.list_of_previous_trips).to eq ([ { :entry => entry_station,:exit => exit_station } ])
    end
  end

end
