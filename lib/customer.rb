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
    total_amount = 0
    frequent_renter_points = 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |rental|
      rental_charge = rental.amount_to_charge
      frequent_renter_points = rental.get_frequent_renter_points
      result += "\t" + rental.movie.title + "\t" + rental_charge.to_s + "\n"
      total_amount += rental_charge
    end

    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end


end
