class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

  def get_frequent_renter_points
   @movie.frequent_renter_points(@days_rented)
  end

  def get_charge
    @movie.amount_to_charge(@days_rented)
  end
end
