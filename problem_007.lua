local helpers = require 'helpers'

local function answer ()
  local count = 0
  for prime in helpers.primes() do
    count = count + 1
    if count == 10001 then
      return prime
    end
  end
end

helpers.elapsed_time(function ()
  print(answer())
end)
