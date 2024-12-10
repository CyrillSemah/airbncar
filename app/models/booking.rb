class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :number_of_people, presence: true, numericality: { greater_than: 0 }
  validate :end_date_after_start_date
  validate :car_available
  validate :number_of_people_within_capacity

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "doit être après la date de début")
    end
  end

  def car_available
    return if car.nil? || start_date.blank? || end_date.blank?
    
    unless car.available?(start_date, end_date)
      errors.add(:base, "La voiture n'est pas disponible pour ces dates")
    end
  end

  def number_of_people_within_capacity
    return if car.nil? || number_of_people.blank?

    if number_of_people > car.capacity
      errors.add(:number_of_people, "ne peut pas dépasser la capacité de la voiture")
    end
  end
end
