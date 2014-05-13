local helpers = require 'helpers'

local function answer ()
  local sum = 0
  for p in helpers.primes() do
    if p < 2000000 then
      sum = sum + p
    else
      break
    end
  end
  return sum
end

helpers.elapsed_time(function ()
  print(answer())
end)
