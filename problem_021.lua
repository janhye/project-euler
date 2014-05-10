local helpers = require 'helpers'

local math = math

local function answer ()
  local dn = {}
  for i = 1, 10000 do
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
    dn[i] = d
  end

  local sum = 0
  for a, b in ipairs(dn) do
    if a ~= b and dn[b] == a then
      sum = sum + a
    end
  end

  return sum
end

helpers.elapsed_time(function ()
  print(answer())
end)
