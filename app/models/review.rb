class Review < ApplicationRecord
  belongs_to :car
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :user_id, uniqueness: { scope: :car_id, message: "has already reviewed this car" }
  validate :user_must_have_booked_car

  private

  def user_must_have_booked_car
    unless car.bookings.where(user: user).where('end_date < ?', Date.today).exists?
      errors.add(:base, "You can only review cars you have rented")
    end
  end
end
