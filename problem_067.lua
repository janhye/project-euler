local helpers = require 'helpers'
local table = table
local math = math
local io = io

local function answer ()
  local tree = {}
  for line in io.lines("problem_067_triangle.txt") do
    table.insert(tree, {})
    for num in line:gmatch("%d+") do
      table.insert(tree[#tree], tonumber(num))
    end
  end
  -- last triangle line is not need to calculate
  for i = #tree - 1, 1, -1 do
    for j = 1, #tree[i] do
      tree[i][j] = tree[i][j] + math.max(tree[i + 1][j], tree[i + 1][j + 1])
    end
  end
  return tree[1][1]
end

helpers.elapsed_time(function ()
  print(answer())
end)
