local helpers = require 'helpers'
local Bignum = require 'bignum'

local function mul (b, n)
  local result = Bignum.new(0)
  for i = 1, n do
    result = result:add(b)
  end
  return result
end

local function answer ()
  local fact = Bignum.new(1)
  for i = 2, 100 do
    fact = mul(fact, i)
  end
  local str = fact:tostring()
  local sum = 0
  for i = 1, #str do
    sum = sum + str:sub(i, i)
  end
  return sum, str
end

helpers.elapsed_time(function ()
  print(answer())
end)
