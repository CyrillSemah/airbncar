module Admin
  class BookingsController < BaseController
    before_action :set_booking, only: [:show, :edit, :update, :destroy]

    def index
      @bookings = Booking.includes(:car, :user).order(created_at: :desc)
    end

    def show
    end

    def edit
    end

    def update
      if @booking.update(booking_params)
        redirect_to admin_booking_path(@booking), notice: 'Réservation mise à jour avec succès.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @booking.destroy
      redirect_to admin_bookings_path, notice: 'Réservation supprimée avec succès.'
    end

    private

    def set_booking
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:start_date, :end_date, :status)
    end
  end
end
