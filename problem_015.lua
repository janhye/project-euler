local helpers = require 'helpers'

local function answer1 ()
  local grid_size = {width = 20, height = 20}
  local routes_count = 0
  local points = {{0, 0}}
  repeat
    local point = points[#points]
    points[#points] = nil

    if point[1] < grid_size.width then
      points[#points + 1] = {point[1] + 1, point[2]}
    end

    if point[2] < grid_size.height then
      points[#points + 1] = {point[1], point[2] + 1}
    end

    if point[1] == grid_size.width and point[2] == grid_size.height then
      routes_count = routes_count + 1
    end
  until #points == 0
  return routes_count
end

local function answer ()
  local grid_size = {width = 20, height = 20}
  local routes = {}
  for r = grid_size.height, 0, -1 do
    if routes[r] == nil then routes[r] = {} end
    for c = grid_size.width, 0, -1 do
      if r == grid_size.height and c == grid_size.width then
        routes[r][c] = 0
      elseif r == grid_size.height or c == grid_size.width then
        routes[r][c] = 1
      else
        routes[r][c] = routes[r][c + 1] + routes[r + 1][c]
      end
    end
  end
  return routes[0][0]
end

helpers.elapsed_time(function ()
  print(answer())
end)
