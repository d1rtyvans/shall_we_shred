module ShredClient
  class SnowDay
    # Default desirable condition variables
    MIN_TEMP = 32.0
    MAX_TEMP = 40.0
    MAX_WIND_SPEED = 20.0

    attr_accessor :earlier_week_accumulation

    def initialize(response)
      @response = response
      @icon     = response.fetch("icon")
    end

    def name
      Time.at(response["time"]).strftime("%A")
    end

    def accumulation
      (response["precipAccumulation"].to_f / 12.0).round(1)
    end

    def desirable?
      (cold? || snowing?) && !(raining? || windy?)
    end

    # desirable
    def cold?
      response["temperatureMin"] < MIN_TEMP && response["temperatureMax"] < MAX_TEMP
    end

    def snowing?
      icon == "snow"
    end

    # undesirable
    def raining?
      icon == "rain"
    end

    def windy?
      response["windSpeed"] > MAX_WIND_SPEED
    end

    def to_s
      "#{name.upcase} - #{Time.at(response['time']).strftime('%b %-d')}\n"\
        "Low: #{response['temperatureMin']} / High: #{response['temperatureMax']} / "\
        "Wind: #{response['windSpeed']} mph\n"\
        "Day Total: #{accumulation} ft.\n"\
        "Earlier Week Total: #{earlier_week_accumulation.to_f.round(1)} ft.\n"
    end

    private
      attr_reader :response, :icon
  end
end
