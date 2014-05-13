local helper = require "lib.helper"
local Bignum = require "lib.bignum"

local function answer ()
  local fact = Bignum.factorial(100)
  local str = fact:tostring()
  local sum = 0
  for i = 1, #str do
    sum = sum + str:sub(i, i)
  end
  return sum, str
end

helper.elapsed_time(function ()
  print(answer())
end)
