class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car
  before_action :set_review, only: [:destroy]
  before_action :ensure_owner, only: [:destroy]

  def create
    @review = @car.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @car, notice: 'Review was successfully posted.'
    else
      redirect_to @car, alert: @review.errors.full_messages.to_sentence
    end
  end

  def destroy
    @review.destroy
    redirect_to @car, notice: 'Review was successfully deleted.'
  end

  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def set_review
    @review = @car.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def ensure_owner
    unless @review.user == current_user
      redirect_to @car, alert: "You can only delete your own reviews."
    end
  end
end
