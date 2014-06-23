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
      @movie = Movie.new("The Little Mermaid", RegularPrice.new)
    end

    it "returns a statement for 1 regular movie for 1 day" do
      expected_statement = create_test_statement(2, 1)
      @rental = Rental.new(@movie, 1)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end

    it "charges more for a regular movie that is rented for more than 2 days" do
      expected_statement = create_test_statement(3.5, 1)
      @rental = Rental.new(@movie, 3)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end

    it "calculate the total frequent renter points and amount if there are multiple rentals for a customer" do
      @movie2 = Movie.new("Snow White", RegularPrice.new)
      @rental1 = Rental.new(@movie, 1)
      @rental2 = Rental.new(@movie2, 1)
      @customer.add_rental(@rental1)
      @customer.add_rental(@rental2)
      @customer.statement.should == expected_statement_with_several_movies
    end
  end

  context "a new release" do
    before(:each) do
      @movie = Movie.new("The Little Mermaid", NewReleasePrice.new)
    end

    it "returns a statement for 1 new release movie for 1 day" do
      expected_statement = create_test_statement(3, 1)
      @rental = Rental.new(@movie, 1)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end

    it "adds 1 more frequent renter point for New Releases rented for more than a day" do
      expected_statement = create_test_statement(6, 2)
      @rental = Rental.new(@movie, 2)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end
  end

  context "a childrens movie" do
    before(:each) do
      @movie = Movie.new("The Little Mermaid", ChildrensPrice.new)
    end

    it "returns a statment for 1 childrens movie for 1 day" do
      expected_statement = create_test_statement(2, 1)
      @rental = Rental.new(@movie, 1)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end


    it "charges extra if a childrens movie is rented for more than 3 days" do
      expected_statement = create_test_statement(3.5, 1)
      @rental = Rental.new(@movie, 4)
      @customer.add_rental(@rental)
      @customer.statement.should == expected_statement
    end
  end

  def create_test_statement(amount_owed, frequent_renter_points)
    "Rental Record for Elizabeth\n" +
    "\tThe Little Mermaid\t#{amount_owed}\n" +
    "Amount owed is #{amount_owed}\n" +
    "You earned #{frequent_renter_points} frequent renter points"
  end

  def expected_statement_with_several_movies
    "Rental Record for Elizabeth\n" +
    "\tThe Little Mermaid\t2\n" +
    "\tSnow White\t2\n" +
    "Amount owed is 4\n" +
    "You earned 2 frequent renter points"
  end
end
