require 'solareventcalculator'

module NewTime
  class NewTime
    attr_accessor :year, :month, :day, :hours, :minutes, :seconds, :fractional

    def initialize(year, month, day, hours, minutes, seconds, fractional)
      @year, @month, @day, @hours, @minutes, @seconds, @fractional = year, month, day, hours, minutes, seconds, fractional
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
      sunrise_today = sunrise(date_time.to_date, latitude, longitude, tz)
      sunset_today = sunset(date_time.to_date, latitude, longitude, tz)

      # During daylight hours?
      if date_time >= sunrise_today && date_time < sunset_today
        start, finish = sunrise_today, sunset_today
        start_hour = 6
        new_date = date_time.to_date
      else
        # Is it before sunrise or after sunset?
        if date_time < sunrise_today
          start_date = date_time.to_date - 1
        else
          start_date = date_time.to_date
        end
        new_date = start_date
        finish_date = start_date + 1
        start_hour = 18
        start = sunset(start_date, latitude, longitude, tz)
        finish = sunrise(finish_date, latitude, longitude, tz)
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
        new_date += 1
      end

      NewTime.new(new_date.year, new_date.month, new_date.day, hours, minutes, seconds, fractional)
    end

    def time_to_s
      if hours > 12
        "%i:%02i pm" % [hours - 12, minutes]
      else
        "%i:%02i am" % [hours, minutes]
      end
    end

    def date_to_s
      Date.new(year, month, day).to_s
    end

    def to_s
      date_to_s + " " + time_to_s
    end
  end
end
