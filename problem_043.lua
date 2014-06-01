local helper = require "lib.helper"
local permgen = helper.permgen
local concat = table.concat
local sub = string.sub
local tonumber = tonumber

local function answer ()
  local a = {0,1,2,3,4,5,6,7,8,9}
  local d = {2,3,5,7,11,13,17}
  local sum = 0
  for p in permgen(a) do
    if p[1] ~= 0 then
      local s = concat(p)
      local is_pandigital_interesting = true
      for i, v in ipairs(d) do
        local n = tonumber(sub(s, 1 + i, 3 + i))
        if n % d[i] ~= 0 then
          is_pandigital_interesting = false
        end
      end

      if is_pandigital_interesting then
        sum = sum + tonumber(s)
      end
    end
  end

  return sum
end

helper.elapsed_time(function ()
  print(answer())
end)
