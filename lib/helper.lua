local helper = {}

local os = os
local math = math
local coroutine = coroutine
local string = string

function helper.elapsed_time (fn)
  local t = os.clock()
  fn()
  local elapsed = os.clock() - t
  print(string.format("elapsed time: %.2fms\n", elapsed * 1000))
  return elapsed
end

function helper.remove_at (t, n)
  local v = t[n]
  for i = n, #t do
    if i == #t then 
      t[i] = nil
    else
      t[i] = t[i + 1]
    end
  end
  return v
end

function helper.factorial (n)
  local f = 1
  for i = 1, n do
    f = f * i
  end
  return f
end

function helper.find (array, fn)
  for i, v in ipairs(array) do 
    if fn(v) then
      return i, v
    end
  end
  return nil, nil
end

local function primesgen ()
  local first_prime = 2
  local prime_numbers = {first_prime}
  coroutine.yield(first_prime)
  for num = 3, math.huge do
    local is_prime_number = true
    local limit = num ^ 0.5
    for _, v in ipairs(prime_numbers) do
      if v > limit then break end
      if num % v == 0 then
        is_prime_number = false
        break
      end
    end
    if is_prime_number then
      prime_numbers[#prime_numbers + 1] = num
      coroutine.yield(num)
    end
  end
end

function helper.primes ()
  return coroutine.wrap(function () primesgen() end)
end

return helper
