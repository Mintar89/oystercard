class Oystercard

  attr_reader :balance
  MAXIMUM_LIMIT = 90
  
  def initialize
    @balance = 0
    @use = false
  end

  def top_up(value)
    fail "Maximum limit of #{ :MAXIMUM_LIMIT } reached" if @balance >= MAXIMUM_LIMIT
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    @use = true
  end
  
  def touch_out
    @use = false
  end
  
  def in_journey?
    @use 
  end

end