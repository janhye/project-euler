local helper = require "lib.helper"
local huge = math.huge
local is_prime = helper.is_prime
local primes = helper.primes

local function answer ()
  for n = 9, huge, 2 do
    if not is_prime(n) then
      local is_goldbach = false
      for p in primes() do
        if p > n then break end

        local d = (n - p) / 2
        for i = 1, huge do
          if i * i == d then
            is_goldbach = true
            break
          elseif i * i > d then
            break
          end
        end
      end

      if not is_goldbach then
        return n
      end
    end
  end
end

helper.elapsed_time(function ()
  print(answer())
end)
