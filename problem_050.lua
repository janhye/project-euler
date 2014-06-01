local helper = require "lib.helper"
local primes = helper.primes

local function answer ()
  local ps = {}
  local ps_set = {}
  for p in primes() do
    if p > 1000000 then break end
    ps[#ps+1] = p
    ps_set[p] = true
  end

  -- 547 is longest prime sum below 1000000
  local MAX_COUNT = 547
  local longest = 0
  local longest_prime
  local sum = 0
  local count = 0
  local i = 1
  local c = 1
  while MAX_COUNT - c + 1 > longest do
    if i > MAX_COUNT then
      sum = 0
      count = 0
      i = c + 1
      c = c + 1
    end

    sum = sum + ps[i]
    count = count + 1
    if ps_set[sum] then
      if longest < count then
        longest = count
        longest_prime = sum
      end
    end

    i = i + 1
  end

  return longest_prime, longest
end

helper.elapsed_time(function ()
  print(answer())
end)
