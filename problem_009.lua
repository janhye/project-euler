local helper = require "lib.helper"

local function answer ()
  local c
  for a = 2, 333 do
    for b = 3, 499 do
      c = 1000 - a - b
      if a ^ 2 + b ^ 2 == c ^ 2 then
        return a * b * c, a, b, c
      end
    end
  end
end

helper.elapsed_time(function ()
  print(answer())
end)
