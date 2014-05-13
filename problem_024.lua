local helper = require "lib.helper"

local table = table
local math = math

local function answer ()
  local permutation = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
  local buf = {}
  local n = 1000000 - 1
  while #permutation > 0 do
    local fact = helper.factorial(#permutation - 1)
    local j = math.floor(n / fact)
    n = n % fact
    buf[#buf + 1] = helper.remove_at(permutation, j + 1)
  end

  return table.concat(buf)
end

helper.elapsed_time(function ()
  print(answer())
end)
