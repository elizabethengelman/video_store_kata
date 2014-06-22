require 'pry'

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
    frequent_renter_points = 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |rental|
      rental_charge = rental.amount_to_charge
      frequent_renter_points += rental.get_frequent_renter_points
      result += "\t" + rental.movie.title + "\t" + rental_charge.to_s + "\n"
    end

    result += "Amount owed is #{get_total_amount(@rentals)}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end

  def get_total_amount(rentals)
    rentals.map(&:amount_to_charge).reduce(0) do |sum, amount|
      sum + amount
    end
  end

end
