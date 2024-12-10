require "test_helper"

class CarTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @car = Car.new(
      title: "Belle voiture",
      description: "Une très belle voiture à louer",
      location: "Paris",
      capacity: 5,
      size: "medium",
      daily_price: 50.0,
      user: @user
    )
  end

  test "should be valid" do
    assert @car.valid?
  end

  test "title should be present" do
    @car.title = ""
    assert_not @car.valid?
  end

  test "description should be present and have minimum length" do
    @car.description = "court"
    assert_not @car.valid?
    @car.description = "Une description suffisamment longue"
    assert @car.valid?
  end

  test "location should be present" do
    @car.location = ""
    assert_not @car.valid?
  end

  test "capacity should be positive" do
    @car.capacity = 0
    assert_not @car.valid?
    @car.capacity = -1
    assert_not @car.valid?
  end

  test "daily_price should be positive" do
    @car.daily_price = 0
    assert_not @car.valid?
    @car.daily_price = -1
    assert_not @car.valid?
  end

  test "should check availability correctly" do
    @car.save
    # Créer une réservation existante
    Booking.create!(
      start_date: Date.today + 1,
      end_date: Date.today + 3,
      user: @user,
      car: @car,
      number_of_people: 2
    )

    # Test des périodes qui se chevauchent
    assert_not @car.available?(Date.today + 2, Date.today + 4)
    assert_not @car.available?(Date.today, Date.today + 2)
    assert_not @car.available?(Date.today + 1, Date.today + 3)

    # Test des périodes disponibles
    assert @car.available?(Date.today + 4, Date.today + 6)
  end
end
