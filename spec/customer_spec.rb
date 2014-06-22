require 'rspec'
require 'customer'
require 'movie'
require 'rental'

describe Customer do
  before(:each) do
    @customer = Customer.new("Elizabeth")
  end

  it "returns an empty statement if the customer has no rentals" do
    expected_empty_statement = "Rental Record for Elizabeth\n" +
                         "Amount owed is 0\n" +
                         "You earned 0 frequent renter points"
    @customer.statement.should == expected_empty_statement
  end

  context "a regular movie" do
    before(:each) do
      @movie = Movie.new("The Little Mermaid", Movie::REGULAR)
    end

    it "returns a statement for 1 regular movie for 1 day" do
      expected_statement = create_test_statement(Movie::REGULAR, 2, 1, 1)
      @rental = Rental.new(@movie, 1)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end

    it "charges more for a regular movie that is rented for more than 2 days" do
      expected_statement = create_test_statement(Movie::REGULAR, 3.5, 3, 1)
      @rental = Rental.new(@movie, 3)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end
  end

  context "a new release" do
    before(:each) do
      @movie = Movie.new("The Little Mermaid", Movie::NEW_RELEASE)
    end

    it "returns a statement for 1 new release movie for 1 day" do
      expected_statement = create_test_statement(Movie::NEW_RELEASE, 3, 1, 1)
      @rental = Rental.new(@movie, 1)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end

    it "adds 1 more frequent renter point for New Releases rented for more than a day" do
      expected_statement = create_test_statement(Movie::NEW_RELEASE, 6, 2, 2)
      @rental = Rental.new(@movie, 2)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end
  end

  context "a childrens movie" do
    before(:each) do
      @movie = Movie.new("The Little Mermaid", Movie::CHILDRENS)
    end

    it "returns a statment for 1 childrens movie for 1 day" do
      expected_statement = create_test_statement(Movie::CHILDRENS, 2, 1, 1)
      @rental = Rental.new(@movie, 1)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end


    it "charges extra if a childrens movie is rented for more than 3 days" do
      expected_statement = create_test_statement(Movie::CHILDRENS, 3.5, 1, 1)
      @rental = Rental.new(@movie, 4)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end
  end

  def create_test_statement(movie_type, amount_owed, days_rented, frequent_renter_points)
    expected_statement = "Rental Record for Elizabeth\n" +
                         "\tThe Little Mermaid\t#{amount_owed}\n" +
                         "Amount owed is #{amount_owed}\n" +
                         "You earned #{frequent_renter_points} frequent renter points"
  end
end
