local helpers = require 'helpers'

local math = math

local function answer ()
  local sum = 0
  local abundant_nums = {}
  for i = 1, 28123 do
    local limit = i ^ 0.5
    local d = 0
    for j = 1, math.floor(limit) do
      if i % j == 0 then
        if j == 1 or j ^ 2 == i then
          d = d + j
        else
          d = d + j + (i / j)
        end
      end
    end
    if d > i then 
      abundant_nums[#abundant_nums + 1] = i
    end
  end

  local buf = {}
  for i = 1, #abundant_nums do
    for j = i, #abundant_nums do
      local s = abundant_nums[i] + abundant_nums[j]
      if s <= 28123 then
        buf[s] = 1
      else
        break
      end
    end
  end

  for i = 1, 28123 do
    if buf[i] == nil then
      sum = sum + i
    end
  end
  return sum
end

helpers.elapsed_time(function ()
  print(answer())
end)
