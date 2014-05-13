local helper = require 'lib.helper'

local function multiples_of_3_or_5 (num)
  if num % 3 == 0 or num % 5 == 0 then
    return true
  else
    return false
  end
end

local function calculate (below)
  local result = 0
  for i = 1, below - 1 do
    if multiples_of_3_or_5(i) then 
      result = result + i 
    end
  end
  return result
end

helper.elapsed_time(function ()
  print(calculate(1000))
end)
