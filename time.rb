#!/usr/bin/env ruby
require 'solareventcalculator'

latitude = -33.714955
longitude = 150.311407
tz = "Australia/Sydney"

c = SolarEventCalculator.new(Date.today, latitude, longitude)

sunrise = c.compute_official_sunrise(tz)
sunset = c.compute_official_sunset(tz)

puts "Official sunrise: #{sunrise} and sunset: #{sunset}"
