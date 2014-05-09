local helpers = require 'helpers'
local Bignum = require 'bignum'

local function answer ()
  local b = Bignum.pow2(1000)
  local digits = b:tostring()
  local sum = 0
  for i = 1, #digits do
    sum = sum + digits:sub(i, i)
  end
  return sum 
end

helpers.elapsed_time(function ()
  print(answer())
end)
