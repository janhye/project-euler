local helper = require "lib.helper"
local huge = math.huge
local primes = helper.primes

local function answer ()
  local ps = {}
  local i = 1
  for p in primes() do
    ps[#ps+1] = p
    if i == 100000 then break end
    i = i + 1
  end

  for i = 1, huge do
    local have_four_distinct_prime_factors = true
    for n = i, i + 3 do
      local count = 0
      local m = n
      for _, p in ipairs(ps) do
        if p > m then break end

        if m % p == 0 then
          count = count + 1
        end

        while m % p == 0 do
          m = m / p
        end
      end

      if count ~= 4 then
        have_four_distinct_prime_factors = false
        break
      end
    end

    if have_four_distinct_prime_factors then
      return i
    end
  end
end

helper.elapsed_time(function ()
  print(answer())
end)
