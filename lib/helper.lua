local helper = {}

local os = os
local floor, ceil = math.floor, math.ceil
local yield, wrap = coroutine.yield, coroutine.wrap
local string = string
local table = table
local io = io

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
  yield(first_prime)
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
      yield(num)
    end
  end
end

function helper.primes ()
  return wrap(function () primesgen() end)
end

function helper.is_prime (n)
  if n <= 1 or floor(n) ~= ceil(n) then 
    return false 
  end

  local limit = n ^ 0.5
  for i = 2, limit do
    if n % i == 0 then
      return false
    end
  end
  return true
end

function helper.set_default (t, d)
  local mt = { __index = function () return d end }
  setmetatable(t, mt)
end

local function permgen (a, n)
  n = n or #a
  if n <= 1 then
    yield(a)
  else
    -- default for 'n' is size of 'a'
    -- nothing to change?
    for i = 1, n do
      -- put i-th element as the last one
      a[n], a[i] = a[i], a[n]
      -- generate all permutations of the other elements
      permgen(a, n - 1)
      -- restore i-th element
      a[n], a[i] = a[i], a[n]
    end
  end
end

function helper.permgen (a, n)
  return wrap(function () permgen(a, n) end)
end

local function combinegen (a, n, m, subset)
  if m <= 0 then
    yield(subset)
    return
  end

  for i = n, m, -1 do
    subset[m] = a[i]
    combinegen(a, i - 1, m - 1, subset)
  end
end

function helper.combinegen (a, m)
  local subset = {}
  return wrap(function () combinegen(a, #a, m, subset) end)
end

-- 分数化简
function helper.lowest_common_terms (numerator, denominator)
  local n, d = numerator, denominator
  local limit = n ^ 0.5

  local i = 2
  while i <= limit do
    if n % i == 0 then
      if d % i == 0 then
        d = d / i
        n = n / i
        limit = n ^ 0.5
        i = 1
      elseif d % (n / i) == 0 then
        d = d / (n / i)
        n = i
        limit = n ^ 0.5
        i = 1
      end
    end
    i = i + 1
  end

  if d % n == 0 then
    d = d / n
    n = 1
  end

  return n, d
end

function helper.split_digits (n)
  local digits = {}
  repeat
    local m = n % 10
    n = (n - m) / 10
    digits[#digits+1] = m
  until n == 0

  return digits
end

function helper.digits_to_number (digits)
  local n = 0
  for i, v in ipairs(digits) do
    n = n + v * 10 ^ (i - 1)
  end
  
  return n
end

function helper.pp (t)
  for i, v in ipairs(t) do
    io.write(v)
    if i ~= #t then 
      io.write(", ")
    else
      io.write("\n")
    end
  end
end

return helper
