class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cars, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booked_cars, through: :bookings, source: :car

  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
end
