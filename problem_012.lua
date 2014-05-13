local helper = require "lib.helper"

local math = math
---[[
local function answer ()
  local triangle_num
  local num = 1
  while true do
    triangle_num = (num + 1) * num / 2
    local divisors = 0
    local limit = math.sqrt(triangle_num)
    local i = 1
    while i < limit do
      if triangle_num % i == 0 then divisors = divisors + 2 end
      if divisors > 500 then
        return triangle_num
      end
      i = i + 1
    end
    num = num + 1
  end
end
--]]

--[[
local function num_divisors (n)
  if n % 2 == 0 then n = n/2 end
  local divisors = 1
  local count = 0
  while n % 2 == 0 do
    count = count + 1
    n = n/2
  end
  divisors = divisors * (count + 1)
  local p = 3
  while n ~= 1 do
    count = 0
    while n % p == 0 do
      count = count + 1
      n = n/p
    end
    divisors = divisors * (count + 1)
    p = p + 2
  end
  return divisors
end
 
local function find_triangular_index (factor_limit)
  local n = 1
  local lnum, rnum = num_divisors(n), num_divisors(n+1)
  while lnum * rnum < 500 do
    n = n + 1
    lnum, rnum = rnum, num_divisors(n+1)
  end
  return n
end
--]]

helper.elapsed_time(function ()
  --print(find_triangular_index(500))
  print(answer())
end)
