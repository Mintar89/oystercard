class Oystercard
  
  attr_accessor :balance, :entry_station
  attr_accessor :balance, :entry_station, :list_of_previous_trips, :exit_station
  MAXIMUM_LIMIT = 90
  MIN_FARE = 1
  
  def initialize
    @balance = 0
    @entry_station = nil
    @list_of_previous_trips = []
    @exit_station = nil
  end


  def top_up(value)
    fail "Maximum balance exceeded" if max?(value)
    @balance += value
  end

  def touch_in(station)
    fail 'Insufficient funds, top up card' if min_fare?
    @entry_station = station
  end
  
  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    @list_of_previous_trips << { :entry => @entry_station,:exit => @exit_station }
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