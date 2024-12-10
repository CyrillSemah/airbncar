require "open-uri"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Cleaning existing data
puts "Cleaning database..."
Car.destroy_all
User.destroy_all

# Creating users
puts "Creating users..."
user1 = User.create!(
  email: "john@example.com",
  password: "password123",
  first_name: "John",
  last_name: "Doe"
)

user2 = User.create!(
  email: "jane@example.com",
  password: "password123",
  first_name: "Jane",
  last_name: "Smith"
)

# Creating cars
puts "Creating cars..."

cars_data = [
  {
    car_attributes: {
      title: "Tesla Model S 2023",
      description: "Luxury electric sedan with autopilot capabilities",
      daily_price: 150,
      capacity: 5,
      location: "Paris",
      user: user1,
      size: "Large"
    },
    image_url: "https://images.unsplash.com/photo-1560958089-b8a1929cea89?q=80"
  },
  {
    car_attributes: {
      title: "Porsche 911 Carrera 2022",
      description: "Classic sports car with outstanding performance",
      daily_price: 200,
      capacity: 2,
      location: "Lyon",
      user: user2,
      size: "Medium"
    },
    image_url: "https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80"
  },
  {
    car_attributes: {
      title: "Mercedes-Benz S-Class 2023",
      description: "Ultimate luxury sedan with advanced technology",
      daily_price: 180,
      capacity: 5,
      location: "Nice",
      user: user1,
      size: "Large"
    },
    image_url: "https://images.unsplash.com/photo-1553440569-bcc63803a83d?q=80"
  },
  {
    car_attributes: {
      title: "BMW M4 2022",
      description: "High-performance luxury coupe",
      daily_price: 170,
      capacity: 4,
      location: "Marseille",
      user: user2,
      size: "Medium"
    },
    image_url: "https://images.unsplash.com/photo-1607853554439-0069ec0f29b6?q=80"
  },
  {
    car_attributes: {
      title: "Audi RS7 2023",
      description: "Powerful sportback with elegant design",
      daily_price: 190,
      capacity: 4,
      location: "Bordeaux",
      user: user1,
      size: "Large"
    },
    image_url: "https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?q=80"
  },
  {
    car_attributes: {
      title: "Lamborghini Huracán 2022",
      description: "Exotic supercar with incredible performance",
      daily_price: 300,
      capacity: 2,
      location: "Cannes",
      user: user2,
      size: "Small"
    },
    image_url: "https://images.unsplash.com/photo-1544636331-e26879cd4d9b?q=80"
  },
  {
    car_attributes: {
      title: "Ferrari F8 Tributo 2023",
      description: "Iconic Italian supercar",
      daily_price: 350,
      capacity: 2,
      location: "Monaco",
      user: user1,
      size: "Small"
    },
    image_url: "https://images.unsplash.com/photo-1592198084033-aade902d1aae?q=80"
  },
  {
    car_attributes: {
      title: "Bentley Continental GT 2022",
      description: "Ultra-luxury grand tourer",
      daily_price: 250,
      capacity: 4,
      location: "Lille",
      user: user1,
      size: "Large"
    },
    image_url: "https://images.unsplash.com/photo-1580273916550-e323be2ae537?q=80"
  },
  {
    car_attributes: {
      title: "Maserati Ghibli 2023",
      description: "Italian luxury sports sedan",
      daily_price: 170,
      capacity: 4,
      location: "Strasbourg",
      user: user2,
      size: "Medium"
    },
    image_url: "https://images.unsplash.com/photo-1605515298946-d062f2e9da53?q=80"
  }
]

cars_data.each do |data|
  car = Car.new(data[:car_attributes])
  # Télécharger l'image depuis l'URL et l'attacher à la voiture
  file = URI.open(data[:image_url])
  car.photos.attach(io: file, filename: "#{car.title.parameterize}.jpg", content_type: "image/jpeg")
  if car.save
    puts "Created #{car.title}"
  else
    puts "Failed to create #{car.title}"
    puts "Errors: #{car.errors.full_messages.join(', ')}"
  end
end

puts "Finished! Created #{Car.count} cars"
