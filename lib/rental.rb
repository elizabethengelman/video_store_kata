class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

  def get_frequent_renter_points
    points = 1
    # add bonus for a two day new release rental
    if @movie.price_code == Movie::NEW_RELEASE && @days_rented > 1
      points += 1
    end
    points
  end

  def get_charge
    @movie.amount_to_charge(@days_rented)
  end
end
