class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]

  # GET /cars/:car_id/bookings
  def index
    @car = Car.find(params[:car_id])
    @bookings = @car.bookings
  end

  # POST /cars/:car_id/bookings
  def create
    @car = Car.find(params[:car_id])
    @booking = @car.bookings.build(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to car_path(@car), notice: "Booking successfully created!"
    else
      redirect_to car_path(@car), alert: "Unable to create booking."
    end
  end

  # GET /bookings/:id
  def show; end

  # DELETE /bookings/:id
  def destroy
    @booking.destroy
    redirect_to cars_path, notice: "Booking successfully deleted!"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :people)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
