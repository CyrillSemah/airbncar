class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_owner, only: [:edit, :update, :destroy]

  def index
    @cars = Car.all
    @cars = @cars.where("location ILIKE ?", "%#{params[:location]}%") if params[:location].present?
    @cars = @cars.where("capacity >= ?", params[:capacity]) if params[:capacity].present?
    
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      
      @cars = @cars.select do |car|
        car.available?(start_date, end_date)
      end
    end
  end

  def show
    @booking = Booking.new
    @bookings = @car.bookings.includes(:user).order(start_date: :asc)
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
    params.require(:car).permit(:title, :description, :location, :capacity, :size, :daily_price, :photo)
  end

  def ensure_owner
    unless @car.user == current_user
      redirect_to cars_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
    end
  end
end
