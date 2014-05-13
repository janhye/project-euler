local helper = require 'lib.helper'

local function sum_even_fibs (target)
  local pre = 1
  local current = 1
  local result = 0
  while current <= target do
    pre, current = current, current + pre
    if current > target then break end
    if current % 2 == 0 then
      result = result + current
    end
  end
  return result
end

helper.elapsed_time(function ()
  print(sum_even_fibs(4000000))
end)
