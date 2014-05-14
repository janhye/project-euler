local helper = require "lib.helper"
local math = math

local function answer ()
  local sum = 0
  local digits = 5
  -- 1 is skip 
  -- 6 * 9^5 = 354294, 7 * 9^5 = 413343, 
  -- so end up to 6 digits, got upper bound 354294
  for i = 2, 354294 do
    local r = i
    local digits_pow_sum = 0
    repeat
      local d = r % 10
      digits_pow_sum = digits_pow_sum + d ^ digits 
      r = math.floor(r / 10)
    until r == 0
    if digits_pow_sum == i then
      sum = sum + i
    end
  end
  return sum
end

helper.elapsed_time(function ()
  print(answer())
end)
