class Oystercard

  attr_reader :balance
  MAXIMUM_LIMIT = 90
  
  def initialize(in_journey = false)
    @balance = 0
    @in_journey = in_journey
  end

  def top_up(value)
    fail "Maximum balance exceeded" if balance + value > MAXIMUM_LIMIT
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    @in_journey = true
  end
  
  def touch_out
    @in_journey = false
  end
  
  def in_journey?
    @in_journey
  end

end