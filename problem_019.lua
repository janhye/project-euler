local helpers = require 'helpers'
local math = math

local function is_leap_year (year)
  if year % 400 == 0 or (year % 4 == 0 and year % 100 ~= 0) then
    return true
  else
    return false
  end
end

local function sunday_mod (days)
  local s = 7 - days % 7
  if s == 7 then s = 0 end
  return s
end

local function answer ()
  local s
  if is_leap_year(1900) then
    s = sunday_mod(366 - 6)
  else
    s = sunday_mod(365 - 6)
  end

  local count = 0
  local months_days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
  for i = 1901, 2000 do
    for j = 1, #months_days do
      if s == 0 then count = count + 1 end
      if is_leap_year(i) and j == 2 then
        s = sunday_mod(months_days[j] + 1 - s)
      else
        s = sunday_mod(months_days[j] - s)
      end
    end
  end

  return count
end

helpers.elapsed_time(function ()
  print(answer())
end)
