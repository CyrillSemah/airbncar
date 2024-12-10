module Admin
  class CarsController < BaseController
    before_action :set_car, only: [:show, :edit, :update, :destroy]

    def index
      @cars = Car.includes(:user).order(created_at: :desc)
    end

    def show
    end

    def edit
    end

    def update
      if @car.update(car_params)
        redirect_to admin_car_path(@car), notice: 'Voiture mise à jour avec succès.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @car.destroy
      redirect_to admin_cars_path, notice: 'Voiture supprimée avec succès.'
    end

    private

    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:title, :description, :location, :capacity, 
                                :size, :daily_price, :photo)
    end
  end
end
