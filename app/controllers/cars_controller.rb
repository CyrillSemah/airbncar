class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  def index
    @cars = Car.all
  end

  # GET /cars/:id
  def show
    @bookings = @car.bookings
    @booking = Booking.new
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # POST /cars
  def create
    @car = current_user.cars.build(car_params)
    if @car.save
      redirect_to @car, notice: "Car successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /cars/:id/edit
  def edit; end

  # PATCH/PUT /cars/:id
  def update
    if @car.update(car_params)
      redirect_to @car, notice: "Car successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cars/:id
  def destroy
    @car.destroy
    redirect_to cars_path, notice: "Car successfully deleted!"
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:title, :description, :location, :capacity, :size, :daily_price)
  end
end
