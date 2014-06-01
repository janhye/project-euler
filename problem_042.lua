local helper = require "lib.helper"
local open = io.open
local assert = assert
local gmatch = string.gmatch
local byte = string.byte
local floor = math.floor

local function answer ()
  local count = 0
  local f = assert(open("problem_042_words.txt", "r"))
  local c = f:read("*a")
  for word in gmatch(c, "%a+") do
    local t = 0
    for i = 1, #word do
      t = t + byte(word, i) - 64
    end

    -- Quadratic formula
    local n = (-1 + (1 + 4 * 2 * t) ^ 0.5) / 2
    if n == floor(n) then
      count = count + 1
    end
  end
  f:close()

  return count
end

helper.elapsed_time(function ()
  print(answer())
end)
