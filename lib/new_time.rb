require 'solareventcalculator'

class NewTime
  attr_accessor :hours, :minutes, :seconds, :fractional

  def initialize(hours, minutes, seconds, fractional)
    @hours, @minutes, @seconds, @fractional = hours, minutes, seconds, fractional
  end

  def self.current_time(latitude, longitude, tz)
    convert(DateTime.now, latitude, longitude, tz)
  end

  def self.convert(date_time, latitude, longitude, tz)
    yesterday = SolarEventCalculator.new(date_time.to_date - 1, latitude, longitude)
    today = SolarEventCalculator.new(date_time.to_date, latitude, longitude)
    tomorrow = SolarEventCalculator.new(date_time.to_date + 1, latitude, longitude)

    sunset_yesterday = yesterday.compute_official_sunset(tz)
    sunrise_today = today.compute_official_sunrise(tz)
    sunset_today = today.compute_official_sunset(tz)
    sunrise_tomorrow = tomorrow.compute_official_sunrise(tz)

    if date_time < sunrise_today
      start, finish = sunset_yesterday, sunrise_today
      start_hour = 18
    elsif date_time < sunset_today
      start, finish = sunrise_today, sunset_today
      start_hour = 6
    else
      start, finish = sunset_today, sunrise_tomorrow
      start_hour = 18
    end

    seconds = (start_hour + (date_time - start).to_f / (finish - start) * 12) * 60 * 60

    fractional = seconds - seconds.floor
    seconds = seconds.floor
    minutes = seconds / 60
    seconds -= minutes * 60
    hours = minutes / 60
    minutes -= hours * 60
    hours -= 24 if hours >= 24

    NewTime.new(hours, minutes, seconds, fractional)
  end

  def to_s
    if hours > 12
      "%i:%02i pm" % [hours - 12, minutes]
    else
      "%i:%02i am" % [hours, minutes]
    end
  end
end