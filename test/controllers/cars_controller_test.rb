require "test_helper"

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @car = cars(:one)
    sign_in @user
  end

  test "should get index" do
    get cars_url
    assert_response :success
  end

  test "should get new" do
    get new_car_url
    assert_response :success
  end

  test "should create car" do
    assert_difference('Car.count') do
      post cars_url, params: {
        car: {
          title: "Test Car",
          description: "A test car description",
          location: "Test Location",
          capacity: 4,
          size: "Medium",
          daily_price: 50.00
        }
      }
    end
    assert_redirected_to car_url(Car.last)
  end

  test "should show car" do
    get car_url(@car)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_url(@car)
    assert_response :success
  end

  test "should update car" do
    patch car_url(@car), params: {
      car: {
        title: "Updated Title"
      }
    }
    assert_redirected_to car_url(@car)
    @car.reload
    assert_equal "Updated Title", @car.title
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete car_url(@car)
    end
    assert_redirected_to cars_url
  end
end
