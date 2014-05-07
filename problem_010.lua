helpers = require 'helpers'

--[[
answer1():
142913828922
elapsed time: 897482.70ms

answer():
142913828922
elapsed time: 4007.32ms
--]]

local math = math

local function answer1 ()
  local primes = {2}
  local num = 3
  local sum = 2

  while num < 2000000 do
    local is_primes = true

    for i = 1, #primes do
      if num % primes[i] == 0 then
        is_primes = false
        break
      end
    end

    if is_primes then
      table.insert(primes, num)
      sum = sum + num
    end

    num = num + 1
  end

  return sum
end

local function answer ()
  local primes = {2}
  local num = 3
  local sum = 2
  local limit = math.sqrt(2000000)

  while num < 2000000 do
    local is_primes = true

    for i = 1, #primes do
      if num % primes[i] == 0 then
        is_primes = false
        break
      end
    end

    if is_primes then
      if num < limit then
        table.insert(primes, num)
      end
      sum = sum + num
    end

    num = num + 1
  end

  return sum
end

helpers.elapsed_time(function ()
  print(answer())
end)
