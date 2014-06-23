class Movie
  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price)
    @title = title
    @price = price
  end

  def amount_to_charge(days_rented)
    @price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end
end

class RegularPrice
  def charge(days_rented)
    amount = 2
    if days_rented > 2
      amount += (days_rented - 2) * 1.5
    end
   amount
  end

  def frequent_renter_points(days_rented)
    1
  end
end

class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points(days_rented)
    points = 1
    if days_rented > 1
      points += 1
    end
    points
  end
end

class ChildrensPrice
  def charge(days_rented)
    amount = 2
    if days_rented > 3
      amount += (days_rented - 3) * 1.5
    end
   amount
  end

  def frequent_renter_points(days_rented)
    1
  end
end
