local helper = require "lib.helper"
--local Bignum = require "lib.bignum"
require "lib._BigNum"

local function answer ()
  local sum = BigNum.new("0")
  for i = 1, 1000 do
    local a = BigNum.new(tostring(i))
    local b = BigNum.new(tostring(i))
    local c = BigNum.exp(a, b)
    sum = sum + c
  end

  local s = BigNum.mt.tostring(sum)
  return s:sub(-10, -1)
end

helper.elapsed_time(function ()
  print(answer())
end)
