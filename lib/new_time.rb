require 'solareventcalculator'

module NewTime
  class NewTime
    attr_accessor :year, :month, :day, :rollover, :hours, :minutes, :seconds, :fractional

    def initialize(year, month, day, rollover, hours, minutes, seconds, fractional)
      @year, @month, @day, @rollover, @hours, @minutes, @seconds, @fractional = year, month, day, rollover, hours, minutes, seconds, fractional
    end

    def self.current_time(latitude, longitude, tz)
      convert(DateTime.now, latitude, longitude, tz)
    end

    def self.sunrise(date, latitude, longitude, tz)
      SolarEventCalculator.new(date, latitude, longitude).compute_official_sunrise(tz)
    end

    def self.sunset(date, latitude, longitude, tz)
      SolarEventCalculator.new(date, latitude, longitude).compute_official_sunset(tz)
    end

    def self.convert(date_time, latitude, longitude, tz)
      sunset_yesterday = sunset(date_time.to_date - 1, latitude, longitude, tz)
      sunrise_today = sunrise(date_time.to_date, latitude, longitude, tz)
      sunset_today = sunset(date_time.to_date, latitude, longitude, tz)
      sunrise_tomorrow = sunrise(date_time.to_date + 1, latitude, longitude, tz)

      # During daylight hours?
      if date_time >= sunrise_today && date_time < sunset_today
        start, finish = sunrise_today, sunset_today
        start_hour = 6
      else
        # Is it before sunrise or after sunset?
        if date_time < sunrise_today
          start, finish = sunset_yesterday, sunrise_today
          start_hour = 18
        else
          start, finish = sunset_today, sunrise_tomorrow
          start_hour = 18
        end
      end

      new_seconds = (start_hour + (date_time - start).to_f / (finish - start) * 12) * 60 * 60

      seconds = new_seconds.floor
      fractional = new_seconds - seconds
      minutes = seconds / 60
      seconds -= minutes * 60
      hours = minutes / 60
      minutes -= hours * 60
      if hours >= 24
        hours -= 24
        rollover = true
      else
        rollover = false
      end

      NewTime.new(date_time.year, date_time.month, date_time.day, rollover, hours, minutes, seconds, fractional)
    end

    def to_s
      if hours > 12
        "%i:%02i pm" % [hours - 12, minutes]
      else
        "%i:%02i am" % [hours, minutes]
      end
    end
  end
end
