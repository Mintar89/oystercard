class Oystercard

  attr_reader :balance, :entry_station
  MAXIMUM_LIMIT = 90
  MIN_FARE = 1
  
  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(value)
    fail "Maximum balance exceeded" if max?(value)
    @balance += value
  end

  def touch_in(station)
    fail 'Insufficient funds, top up card' if min_fare?
    @entry_station = station
  end
  
  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end
  
  def in_journey?
    @entry_station
  end

  private 
  def min_fare?
    balance < MIN_FARE
  end 

  def max?(value)
    balance + value > MAXIMUM_LIMIT
  end

  def deduct(value)
    @balance -= value
  end
end