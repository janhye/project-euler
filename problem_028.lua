local helper = require "lib.helper"

local function answer ()
  local n = 1001
  local m = n * n
  local sum = 0
  repeat
    -- 4 corners number
    for i = 1, 4 do
      sum = sum + m
      m = m - n + 1
    end
    n = n - 2
  until m == 1
  -- last m == 1
  sum = sum + m

  return sum
end

helper.elapsed_time(function ()
  print(answer())
end)
