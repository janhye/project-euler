local helper = require "lib.helper"

---[=[
require "lib._BigNum"
local BigNum = BigNum
local function factorial (n)
  local r = BigNum.new(1)
  for i = 1, n do
    r = r * i
  end

  return r
end
--]=]

local function answer ()
  local count = 0
  local b = BigNum.new(1000000)
  for n = 1, 100 do
    for r = 1, n - 1 do
      local c = factorial(n) / (factorial(r) * factorial(n - r))
      if c > b then
        count = count + 1
      end
    end
  end

  return count
end

helper.elapsed_time(function ()
  print(answer())
end)
