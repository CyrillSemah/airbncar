class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many_attached :photos

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :daily_price, presence: true, numericality: { greater_than: 0 }
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :size, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  scope :near_location, ->(location, distance_km = 10) {
    near(location, distance_km, units: :km)
  }

  def available?(start_date, end_date)
    bookings.where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?) OR (start_date >= ? AND end_date <= ?)',
                  start_date, start_date, end_date, end_date, start_date, end_date).empty?
  end

  def average_rating
    reviews.average(:rating)&.round(1) || 0
  end

  def rating_distribution
    total = reviews.count
    return {} if total.zero?

    (1..5).each_with_object({}) do |rating, dist|
      count = reviews.where(rating: rating).count
      dist[rating] = {
        count: count,
        percentage: (count.to_f / total * 100).round
      }
    end
  end
end
