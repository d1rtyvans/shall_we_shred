require "httparty"
require "dotenv"
Dotenv.load

require_relative "snow_day"

class DarkSky
  include HTTParty
  base_uri "https://api.darksky.net"
  format :json

  def self.forecast(lat, long)
    coordinates = [lat, long] * ","
    get("/forecast/#{ENV['SECRET_KEY']}/#{coordinates}")
  end
end

def notify_user(day, week_accumulation)
  puts "You should shred on #{day}"
  puts "Week total: #{week_accumulation} ft."
  puts "-" * 50
end

# Establish relevant variables
AVAILABILITY = ["Thursday", "Friday", "Saturday"]
PHONE_NUMBER = ENV['PHONE_NUMBER']
SIERRA_COORDINATES = [38.7994, -120.0809]

# Get forecast
forecast = DarkSky.forecast(*SIERRA_COORDINATES)
snow_days = forecast["daily"]["data"].map { |day| SnowDay.new(day) }

# Run algorithm
week_accumulation = 0.0
snow_days.each do |day|
  week_accumulation += day.accumulation
  next unless AVAILABILITY.include?(day.name)
  notify_user(day, week_accumulation) if day.desirable?
end
