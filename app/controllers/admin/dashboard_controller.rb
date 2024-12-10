module Admin
  class DashboardController < BaseController
    def index
      @total_cars = Car.count
      @total_bookings = Booking.count
      @total_users = User.count
      @recent_bookings = Booking.includes(:car, :user).order(created_at: :desc).limit(5)
      @recent_cars = Car.includes(:user).order(created_at: :desc).limit(5)
    end
  end
end
