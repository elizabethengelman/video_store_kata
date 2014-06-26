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

  def get_charge
    this_amount = 0
    case @movie.price_code
    when Movie::REGULAR
      this_amount += 2
      this_amount += (@days_rented - 2) * 1.5 if @days_rented > 2
    when Movie::NEW_RELEASE
      this_amount += @days_rented * 3
    when Movie::CHILDRENS
      this_amount += 2
      this_amount += (@days_rented - 3) * 1.5 if @days_rented > 3
    end
    this_amount
  end

  def get_frequent_renter_points
    frequent_renter_points = 1
    # add bonus for a two day new release rental
    if @movie.price_code == Movie::NEW_RELEASE && @days_rented > 1
      frequent_renter_points += 1
    end
    frequent_renter_points
  end
end
