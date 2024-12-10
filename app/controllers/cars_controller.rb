class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    @cars = Car.all
  end

  def show
    @booking = Booking.new
    @bookings = @car.bookings
  end

  def new
    @car = Car.new
  end

  def create
    @car = current_user.cars.build(car_params)
    if @car.save
      redirect_to @car, notice: "La voiture a été ajoutée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to @car, notice: "Les détails de la voiture ont été mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @car.destroy
    redirect_to cars_path, notice: "La voiture a été supprimée avec succès."
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:title, :description, :location, :capacity, :size, :daily_price)
  end
end
