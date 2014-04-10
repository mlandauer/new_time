#!/usr/bin/env ruby
require 'solareventcalculator'

latitude = -33.714955
longitude = 150.311407
tz = "Australia/Sydney"

yesterday = SolarEventCalculator.new(Date.today - 1, latitude, longitude)
today = SolarEventCalculator.new(Date.today, latitude, longitude)
tomorrow = SolarEventCalculator.new(Date.today + 1, latitude, longitude)

sunset_yesterday = yesterday.compute_official_sunset(tz)
sunrise_today = today.compute_official_sunrise(tz)
sunset_today = today.compute_official_sunset(tz)
sunrise_tomorrow = tomorrow.compute_official_sunrise(tz)

time = DateTime.now

if time < sunrise_today
  fraction = (time - sunset_yesterday).to_f / (sunrise_today - sunset_yesterday)
  seconds = (18 + fraction * 12) * 60 * 60
elsif time < sunset_today
  fraction = (time - sunrise_today).to_f / (sunset_today - sunrise_today)
  seconds = (6 + fraction * 12) * 60 * 60
else
  fraction = (time - sunset_today).to_f / (sunrise_tomorrow - sunset_today)
  seconds = (18 + fraction * 12) * 60 * 60
end

fraction = seconds - seconds.floor
seconds = seconds.floor
minutes = seconds / 60
seconds -= minutes * 60
hours = minutes / 60
minutes -= hours * 60
hours -= 24 if hours >= 24

if hours > 12
  puts "%i:%02i pm" % [hours - 12, minutes]
else
  puts "%i:%02i am" % [hours, minutes]
end
