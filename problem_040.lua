local helper = require "lib.helper"
local tostring = tostring
local byte = string.byte

local function d (n)
  local i_pre = 0
  local i_curr = 0
  local j = 1
  while true do
    i_pre = i_curr
    i_curr = i_curr + 9 * j * 10 ^ (j - 1)

    if n > i_pre and n <= i_curr then 
      local m = (n - i_pre) % j
      local num = (n - i_pre - m) / j
      local k
      if m == 0 then
        k = 10 ^ (j - 1) + num - 1
        m = j
      else
        k = 10 ^ (j - 1) + num
      end
      local s = tostring(k)
      -- byte("0", 1) is 48
      return byte(s, m) - 48
    end

    j = j + 1
  end
end

local function answer ()
  return d(1) * d(10) * d(100) * d(1000) * d(10000) * d(100000) * d(1000000)
end

helper.elapsed_time(function ()
  print(answer())
end)
