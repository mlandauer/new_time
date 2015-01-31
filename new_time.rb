#!/usr/bin/env ruby

require_relative "lib/new_time"

latitude = -33.714955
longitude = 150.311407
tz = "Australia/Sydney"

puts NewTime.current_time(latitude, longitude, tz)
