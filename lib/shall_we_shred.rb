require "httparty"
require "dotenv"
Dotenv.load

require_relative "dark_sky"
require_relative "snow_day"
require_relative "snow_week"
require_relative "sms_messenger"

class ShallWeShred
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def run
    SnowWeek.new(user).notify_user
  end
end

SIERRA_COORDINATES = [38.7994, -120.0809]
AVAILABILITY = ["Thursday", "Friday"]

user = OpenStruct.new(
  phone_number: ENV["PHONE_NUMBER"],
  ski_resort: SIERRA_COORDINATES,
  availability: AVAILABILITY,
)

shred_client = ShallWeShred.new(user)
shred_client.run
