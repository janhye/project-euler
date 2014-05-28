local helper = require "lib.helper"

local fact = {[0] = 1}
local function factorial (n)
  if fact[n] ~= nil then 
    return fact[n]
  end

  if n == 0 or n == 1 then
    fact[n] = 1
    return 1
  end

  local r = n * factorial(n - 1)
  fact[n] = r
  return r
end

local function answer ()
  factorial(9)
  local res = 0
  for i = 11, 2540160 do
    local n = 0
    local m = i
    repeat
      local mod = m % 10
      m = (m - mod) / 10
      n = n + fact[mod]
    until m == 0

    if n == i then
      res = res + n
    end
  end
  return res
end

helper.elapsed_time(function ()
  print(answer())
end)
