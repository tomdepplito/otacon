class Address
  attr_accessor :house_num, :street, :zip, :state, :city

  def initialize(house_num, street, city, state, zip)
    @house_num = house_num
    @street    = street
    @city      = city
    @state     = state
    @zip       = zip
  end

  def to_string
    "#{@house_num} #{@street} #{@city}, #{@state} #{@zip}"
  end
end
