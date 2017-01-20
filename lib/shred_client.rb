require "dotenv"; Dotenv.load
require "httparty"
require "twilio-ruby"


require_relative "shred_client/dark_sky"
require_relative "shred_client/snow_day"
require_relative "shred_client/snow_week"
require_relative "shred_client/sms_messenger"

module ShredClient
  SIERRA_COORDINATES = [38.7994, -120.0809].freeze
  AVAILABILITY = ["Thursday", "Friday"].freeze

  def self.notify_user
    SnowWeek.new(user).notify_user
  end

  def self.user # this will eventually come from db
    @user = OpenStruct.new(
      phone_number: ENV["PHONE_NUMBER"],
      ski_resort: SIERRA_COORDINATES,
      availability: AVAILABILITY,
    )
  end
end
