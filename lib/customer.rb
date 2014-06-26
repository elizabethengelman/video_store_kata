class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do |rental|
      this_amount = 0
      this_amount += rental.get_charge
      result += "\t" + rental.movie.title + "\t" + this_amount.to_s + "\n"
    end

    result += "Amount owed is #{get_total_amount(@rentals)}\n"
    result += "You earned #{get_total_frequent_renter_points(@rentals)} frequent renter points"
    result
  end

  def get_total_amount(rentals)
    rentals.map(&:get_charge).reduce(0) do |sum, amount|
      sum + amount
    end
  end

  def get_total_frequent_renter_points(rentals)
    rentals.map(&:get_frequent_renter_points).reduce(0) do |sum, points|
      sum + points
    end
  end
end

