local helper = require "lib.helper"

local io = io
local table = table
local string = string

local function answer ()
  local buf = {}
  for line in io.lines("problem_022_names.txt") do
    for name in line:gmatch("%a+") do
      buf[#buf + 1] = name
    end
  end

  table.sort(buf)
  local result = 0
  for i, v in ipairs(buf) do
    local sum = 0
    for j = 1, #v do
      sum = sum + (v:byte(j) - 64)
    end
    result = result + sum * i
  end
  return result
end

helper.elapsed_time(function ()
  print(answer())
end)
