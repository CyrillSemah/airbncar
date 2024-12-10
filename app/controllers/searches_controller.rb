class SearchesController < ApplicationController
  def index
    @cars = Car.all

    # Filtrer par localisation et distance
    if params[:location].present?
      @cars = @cars.near(params[:location], params[:distance] || 10)
    end

    # Filtrer par prix
    if params[:price_min].present?
      @cars = @cars.where("price_per_day >= ?", params[:price_min])
    end
    if params[:price_max].present?
      @cars = @cars.where("price_per_day <= ?", params[:price_max])
    end

    # Préparer les marqueurs pour la carte
    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window_html: render_to_string(partial: "cars/map_info_window", locals: { car: car }),
        marker_html: render_to_string(partial: "cars/map_marker")
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @markers }
    end
  end
end
