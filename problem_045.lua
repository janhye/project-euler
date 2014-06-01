local helper = require "lib.helper"
local floor = math.floor
local huge = math.huge

local function is_pentagonal (p)
  local n = (1 + (1 + 24 * p) ^ 0.5) / 6
  if n == floor(n) then
    return true
  else
    return false
  end
end

local function is_hexagonal (h)
  local n = (1 + (1 + 8 * h) ^ 0.5) / 4
  if n == floor(n) then
    return true
  else
    return false
  end
end

local function answer ()
  for n = 286, huge do
    local t = n * (n + 1) / 2
    if is_pentagonal(t) and is_hexagonal(t) then
      return t
    end
  end
end

helper.elapsed_time(function ()
  print(answer())
end)
