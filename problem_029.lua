local helper = require "lib.helper"
local Bignum = require "lib.bignum"

local function answer2 ()
  local set = {}
  local a_max, b_max = 100, 100
  local dist = 0
  for a = 2, a_max do
    for b = 2, b_max do
      local n = Bignum.pow(a, b):tostring()
      if set[n] == nil then
        set[n] = true
        dist = dist + 1
      end
    end
  end
  return dist
end

--[[
NOTE: if you run by luajit 2.0.3, it will get 9220, not same whit lua 5.2
--]]
local function answer ()
  local set = {}
  local a_max, b_max = 100, 100
  local dist = 0
  for a = 2, a_max do
    for b = 2, b_max do
      local n = a ^ b
      if set[n] == nil then
        set[n] = true
        dist = dist + 1
      end
    end
  end
  return dist
end

helper.elapsed_time(function ()
  print(answer())
end)
