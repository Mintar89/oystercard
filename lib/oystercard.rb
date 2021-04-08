class Oystercard

  attr_reader :balance
  MAXIMUM_LIMIT = 90
  MIN_FARE = 1
  
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "Maximum balance exceeded" if max?(value)
    @balance += value
  end

  def touch_in
    fail 'Insufficient funds, top up card' if min_fare?
    
    @in_journey = true
  end
  
  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
  end
  
  def in_journey?
    @in_journey
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