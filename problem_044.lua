local helper = require "lib.helper"
local huge = math.huge
local floor = math.floor

local function answer ()
  for n = 1, huge do
    local pn = n * (3 * n - 1) / 2
    for m = n - 1, 1, -1 do
      local pm = m * (3 * m - 1) / 2
      local sum = pn + pm
      local diff = pn - pm
      -- 3n^2 - n - 2p = 0
      local ns = (1 + (1 + 4 * 3 * 2 * sum) ^ 0.5) / (2 * 3)
      if ns == floor(ns) then
        local nd = (1 + (1 + 4 * 3 * 2 * diff) ^ 0.5) / (2 * 3)
        if nd == floor(nd) then
          return diff
        end
      end
    end
  end
end

helper.elapsed_time(function ()
  print(answer())
end)
