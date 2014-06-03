local helper = require "lib.helper"
local huge = math.huge
local split_digits = helper.split_digits
local find = helper.find

local function answer ()
  for i = 10, huge do
    local digits = split_digits(i)
    local found = true
    for j = 2, 6 do
      local ds = split_digits(i * j)
      for _, v in ipairs(ds) do
        local found_digit = find(digits, function (d) return v == d end)
        if found_digit == nil then 
          found = false
          goto next_i
        end
      end
    end

    if found then
      return i
    end

    ::next_i::
  end

  return r
end

helper.elapsed_time(function ()
  print(answer())
end)
