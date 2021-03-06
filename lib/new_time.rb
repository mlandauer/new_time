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

    # TODO Make seconds a float and get rid of fractional
    def initialize(year, month, day, hours, minutes, seconds, fractional)
      @year, @month, @day, @hours, @minutes, @seconds, @fractional = year, month, day, hours, minutes, seconds, fractional
    end

    def self.current_time(point)
      convert(Time.now, point)
    end

    def self.sunrise(date, point)
      SolarEventCalculator.new(date, point.latitude, point.longitude).compute_official_sunrise(point.tz).to_time
    end

    def self.sunset(date, point)
      SolarEventCalculator.new(date, point.latitude, point.longitude).compute_official_sunset(point.tz).to_time
    end

    # Convert back to "normal" time
    def convert(point)
      today = Date.new(year, month, day)
      new_seconds = seconds + fractional + (minutes + hours * 60) * 60

      # During daylight hours?
      if hours >= 6 && hours < 18
        start = NewTime.sunrise(today, point)
        finish = NewTime.sunset(today, point)
        new_start_hour = 6
      else
        # Is it before sunrise or after sunset?
        if hours < 6
          start = NewTime.sunset(today - 1, point)
          finish = NewTime.sunrise(today, point)
          new_start_hour = 18 - 24
        else
          start = NewTime.sunset(today, point)
          finish = NewTime.sunrise(today + 1, point)
          new_start_hour = 18
        end
      end
      start + (new_seconds.to_f / (60 * 60) - new_start_hour) * (finish - start) / 12
    end

    def self.convert(time, point)
      sunrise_today = sunrise(time.to_date, point)
      sunset_today = sunset(time.to_date, point)

      # During daylight hours?
      if time >= sunrise_today && time < sunset_today
        start, finish = sunrise_today, sunset_today
        new_start_hour = 6
        new_date = time.to_date
      else
        # Is it before sunrise or after sunset?
        if time < sunrise_today
          new_date = time.to_date - 1
        else
          new_date = time.to_date
        end
        new_start_hour = 18
        start = sunset(new_date, point)
        finish = sunrise(new_date + 1, point)
      end

      new_seconds = (new_start_hour + (time - start).to_f / (finish - start) * 12) * 60 * 60

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
