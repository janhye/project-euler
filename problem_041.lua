local helper = require "lib.helper"
local permgen = helper.permgen
local is_prime = helper.is_prime

local function answer ()
  local a = {1,2,3,4,5,6,7,8,9}
  local largest = 0
  for i = #a, 1, -1 do
    if largest ~= 0 then
      break
    end

    for p in permgen(a, i) do
      local n = 0
      for j = 1, i do
        n = n + a[j] * 10 ^ (j - 1)
      end

      if is_prime(n) and largest < n then
        largest = n
      end
    end
  end

  return largest
end

helper.elapsed_time(function ()
  print(answer())
end)
