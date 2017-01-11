class SnowWeek
  def initialize(user)
    @user = user
  end

  def notify_user
    accumulation = 0.0
    snow_days.each do |day|
      accumulation += day.accumulation
      if desirable?(day)
        day.earlier_week_accumulation = accumulation
        SmsMessenger.notify_user(user, day)
      end
    end
  end

  def desirable?(day)
    user.availability.include?(day.name) && day.desirable?
  end

  def snow_days
    DarkSky.forecast(*user.ski_resort).map { |day| SnowDay.new(day) }
  end

  private
    attr_reader :user
end
