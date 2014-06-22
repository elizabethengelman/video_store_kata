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
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"
    this_amount = 0
    @rentals.each do |rental|
      this_amount += amount_to_charge(rental)

      #add frequent renter points
      frequent_renter_points += 1
      # add bonus for a two day new release rental
      if rental.movie.price_code == Movie::NEW_RELEASE && rental.days_rented > 1
        frequent_renter_points += 1
      end

      result += "\t" + rental.movie.title + "\t" + this_amount.to_s + "\n"
      total_amount += this_amount
    end

    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end

  def amount_to_charge(rental)
    # determine amounts for each line
    this_amount = 0
    case rental.movie.price_code
    when Movie::REGULAR
      this_amount += 2
      this_amount += (rental.days_rented - 2) * 1.5 if rental.days_rented > 2
    when Movie::NEW_RELEASE
      this_amount += rental.days_rented * 3
    when Movie::CHILDRENS
      this_amount += 2
      this_amount += (rental.days_rented - 3) * 1.5 if rental.days_rented > 3
    end
    this_amount
  end
end
