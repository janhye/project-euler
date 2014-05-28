local helper = require "lib.helper"
local is_prime = helper.is_prime
local primes = helper.primes

local function split_digits (n)
  local res = {}
  local m
  repeat
    m = n % 10
    n = (n - m) / 10
    res[#res+1] = m
  until n == 0
  return res
end

local function answer ()
  local count = 0

  for p in primes() do
    if p > 1000000 then break end

    local is_circular_prime = true
    local digits = split_digits(p)
    for i = 2, #digits do
      local n = 0
      for j = 0, #digits - 1 do
        local idx = i + j
        if idx > #digits then
          idx = idx - #digits
        end
        n = n + digits[idx] * (10 ^ j)
      end

      if not is_prime(n) then
        is_circular_prime = false
        break
      end
    end

    if is_circular_prime then
      count = count + 1
    end
  end

  return count
end

helper.elapsed_time(function ()
  print(answer())
end)
