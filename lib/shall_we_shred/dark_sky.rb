class DarkSky
  include HTTParty
  base_uri "https://api.darksky.net"
  format :json

  def self.forecast(lat, long)
    coordinates = [lat, long] * ","
    require "pry"; binding.pry
    forecast = get("/forecast/#{ENV['SECRET_KEY']}/#{coordinates}")
    forecast["daily"]["data"]
  end
end
