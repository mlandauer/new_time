require 'solareventcalculator'

module NewTime
  class Point
    attr_accessor :latitude, :longitude, :tz

    def initialize(latitude, longitude, tz)
      @latitude, @longitude, @tz = latitude, longitude, tz
    end
  end

  class NewTime
    attr_accessor :year, :month, :day, :hours, :minutes, :seconds, :fractional

    def initialize(year, month, day, hours, minutes, seconds, fractional)
      @year, @month, @day, @hours, @minutes, @seconds, @fractional = year, month, day, hours, minutes, seconds, fractional
    end

    def self.current_time(point)
      convert(DateTime.now, point.latitude, point.longitude, point.tz)
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
        new_start_hour = 6
        new_date = date_time.to_date
      else
        # Is it before sunrise or after sunset?
        if date_time < sunrise_today
          new_date = date_time.to_date - 1
        else
          new_date = date_time.to_date
        end
        new_start_hour = 18
        start = sunset(new_date, latitude, longitude, tz)
        finish = sunrise(new_date + 1, latitude, longitude, tz)
      end

      new_seconds = (new_start_hour + (date_time - start).to_f / (finish - start) * 12) * 60 * 60

      new_fractional = new_seconds - new_seconds.floor
      new_seconds = new_seconds.floor
      new_minutes = new_seconds / 60
      new_seconds -= new_minutes * 60
      new_hours = new_minutes / 60
      new_minutes -= new_hours * 60
      if new_hours >= 24
        new_hours -= 24
        new_date += 1
      end

      NewTime.new(new_date.year, new_date.month, new_date.day, new_hours, new_minutes, new_seconds, new_fractional)
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
