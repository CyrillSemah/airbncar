class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :location, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :size, presence: true
  validates :daily_price, presence: true, numericality: { greater_than: 0 }

  def available?(start_date, end_date)
    bookings.where('(start_date <= ? AND end_date >= ?) OR (start_date <= ? AND end_date >= ?) OR (start_date >= ? AND end_date <= ?)',
                  start_date, start_date, end_date, end_date, start_date, end_date).empty?
  end
end
