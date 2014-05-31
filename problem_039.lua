local helper = require "lib.helper"

local floor = math.floor

local function answer ()
  local solutions = {}
  for a = 1, 500 do
    for b = 1, a - 1 do
      local c = (a ^ 2 - b ^ 2) ^ 0.5
      if c < b and c == floor(c) then
        local p = a + b + c
        solutions[p] = solutions[p] or 0
        solutions[p] = solutions[p] + 1
      end
    end
  end
  
  local p
  local max_solutions = 0
  for k, v in pairs(solutions) do
    if v > max_solutions then
      p = k
      max_solutions = v
    end
  end

  return p
end

helper.elapsed_time(function ()
  print(answer())
end)
