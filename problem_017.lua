local helper = require "lib.helper"
local math = math
local table = table

local function answer ()
  local numbers = {
    "one", "two", "three", "four", "five", 
    "six", "seven", "eight", "nine", "ten",
    "eleven", "twelve", "thirteen", "fourteen", "fifteen", 
    "sixteen", "seventeen", "eighteen", "nineteen", "twenty",
    [30] = "thirty", [40] = "forty", [50] = "fifty", [60] = "sixty",
    [70] = "seventy", [80] = "eighty", [90] = "ninety"
  }

  for i = 21, 1000 do
    local buf = {}
    local thousand = math.floor(i / 1000)
    local h = i % 1000
    local hundred = math.floor(h / 100)
    local d = h % 100
    if thousand >= 1 then
      buf[#buf + 1] = numbers[thousand]
      buf[#buf + 1] = "thousand"
    end
    if hundred >= 1 then
      buf[#buf + 1] = numbers[hundred]
      buf[#buf + 1] = "hundred"
    end
    if thousand >= 1 or hundred >= 1 then
      if d > 0 then
        buf[#buf + 1] = "and"
        buf[#buf + 1] = numbers[d]
      end
      numbers[i] = table.concat(buf, ' ')
    end
    if d > 0 then
      if numbers[d] == nil then
        local decade = math.floor(d / 10) * 10
        local unit = d % 10
        numbers[d] = numbers[decade] .. "-" .. numbers[unit]
      end
    end
  end

  local result = table.concat(numbers, ','):gsub("[-, ]", "")
  return #result
end

helper.elapsed_time(function ()
  print(answer())
end)
