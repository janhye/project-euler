local helper = require "lib.helper"

local function answer ()
  local count = 0
  for prime in helper.primes() do
    count = count + 1
    if count == 10001 then
      return prime
    end
  end
end

helper.elapsed_time(function ()
  print(answer())
end)
