local helper = require "lib.helper"
local primes = helper.primes
local is_prime = helper.is_prime
local floor = math.floor

local function answer ()
  local sum = 0
  local count = 0 
  for p in primes() do
    if count == 11 then break end

    if p > 10 then
      local is_truncatable_prime = true
      local right_to_left_success = true
      local r = p
      while r > 0 do
        r = floor(r / 10)
        if r == 0 then break end

        if not is_prime(r) then
          right_to_left_success = false
          is_truncatable_prime = false
          break
        end
      end

      if right_to_left_success then
        local d = 10
        while true do
          local r = p % d
          if r == p then break end

          if not is_prime(r) then
            is_truncatable_prime = false
            break
          end
          d = d * 10
        end
      end

      if is_truncatable_prime then
        sum = sum + p
        count = count + 1
      end
    end
  end

  return sum
end

helper.elapsed_time(function ()
  print(answer())
end)
