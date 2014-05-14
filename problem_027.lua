local helper = require "lib.helper"
local is_prime = helper.is_prime

local function answer ()
  local a_result, b_result, n_max = 0, 0, 0
  for a = -999, 999 do
    for b = 1, 999 do
      if is_prime(b) then
        local n = 1
        while is_prime(n ^ 2 + a * n + b) do
          n = n + 1
        end
        if n_max < n then 
          a_result, b_result, n_max = a, b, n
        end
      end
    end
  end
  return a_result * b_result, a_result, b_result, n_max
end

helper.elapsed_time(function ()
  print(answer())
end)
