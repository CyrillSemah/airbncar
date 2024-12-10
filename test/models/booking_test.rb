require "test_helper"

class BookingTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @car = cars(:one)
    @booking = Booking.new(
      start_date: Date.today + 1,
      end_date: Date.today + 3,
      number_of_people: 2,
      user: @user,
      car: @car
    )
  end

  test "should be valid" do
    assert @booking.valid?
  end

  test "should require start_date" do
    @booking.start_date = nil
    assert_not @booking.valid?
  end

  test "should require end_date" do
    @booking.end_date = nil
    assert_not @booking.valid?
  end

  test "should require number_of_people" do
    @booking.number_of_people = nil
    assert_not @booking.valid?
  end

  test "number_of_people should be positive" do
    @booking.number_of_people = 0
    assert_not @booking.valid?
    @booking.number_of_people = -1
    assert_not @booking.valid?
  end

  test "end_date should be after start_date" do
    @booking.end_date = @booking.start_date - 1
    assert_not @booking.valid?
    assert_includes @booking.errors[:end_date], "doit être après la date de début"
  end

  test "should not exceed car capacity" do
    @booking.number_of_people = @car.capacity + 1
    assert_not @booking.valid?
    assert_includes @booking.errors[:number_of_people], "ne peut pas dépasser la capacité de la voiture"
  end

  test "should not allow overlapping bookings" do
    @booking.save!
    
    overlapping_booking = Booking.new(
      start_date: @booking.start_date + 1,
      end_date: @booking.end_date + 1,
      number_of_people: 2,
      user: @user,
      car: @car
    )
    
    assert_not overlapping_booking.valid?
    assert_includes overlapping_booking.errors[:base], "La voiture n'est pas disponible pour ces dates"
  end
end
