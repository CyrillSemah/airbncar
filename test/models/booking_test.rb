require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @car = cars(:one)
    @booking = bookings(:one)
    sign_in @user
  end

  test "should get index" do
    get car_bookings_url(@car)
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post car_bookings_url(@car), params: {
        booking: {
          start_date: Date.today,
          end_date: Date.today + 7,
          people: 2
        }
      }
    end
    assert_redirected_to car_url(@car)
  end

  test "should show booking" do
    get booking_url(@booking)
    assert_response :success
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete booking_url(@booking)
    end
    assert_redirected_to cars_url
  end
end
