class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title = title
    @price_code = price_code
  end

  def get_charge(days_rented)
      require 'pry'
    this_amount = 0
    if @price_code.is_a? RegularPrice
      this_amount += @price_code.get_charge(days_rented)
    else
      case @price_code
      when NEW_RELEASE
        this_amount += days_rented * 3
      when CHILDRENS
        this_amount += 2
        this_amount += (days_rented - 3) * 1.5 if days_rented > 3
      end
    end
    this_amount
  end

  def get_frequent_renter_points(days_rented)
    frequent_renter_points = 1
    # add bonus for a two day new release rental
    if @price_code == NEW_RELEASE && days_rented > 1
      frequent_renter_points += 1
    end
    frequent_renter_points
  end
end

class RegularPrice
  def get_charge(days_rented)
    this_amount = 2
    if days_rented > 2
      this_amount += (days_rented - 2) * 1.5
    end
    this_amount
  end

  def get_frequent_renter_points(days_rented)
    1
  end
end
