class SnowDay
  # Default desirable condition variables
  MIN_TEMP = 32
  MAX_TEMP = 40
  MAX_WIND_SPEED = 20.0

  def initialize(response)
    @response     = response
    @icon         = response.fetch("icon")
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

  # Desirable
  def cold?
    response["temperatureMin"] < MIN_TEMP && response["temperatureMax"] < MAX_TEMP
  end

  def snowing?
    icon == "snow"
  end

  # Undesirable
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
      "Day Total: #{accumulation} ft."
  end

  private
    attr_reader :response, :icon
end
