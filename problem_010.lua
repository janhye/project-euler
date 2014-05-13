local helper = require "lib.helper"

local function answer ()
  local sum = 0
  for p in helper.primes() do
    if p < 2000000 then
      sum = sum + p
    else
      break
    end
  end
  return sum
end

helper.elapsed_time(function ()
  print(answer())
end)
