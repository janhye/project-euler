local helpers = require 'helpers'
local math = math

local function answer ()
  local longest = 0
  local d = 2
  for i = 2, 1000 - 1 do
    local cycle = {}
    local remainder = 1
    while true do
      local factor = math.floor((remainder * 10) / i)
      remainder = (remainder * 10) % i
      if remainder ~= 0 then 
        local idx = helpers.find(cycle, function (n) 
          return n[2] == remainder
        end)
        if idx then 
          if longest < #cycle - idx + 1 then
            longest = #cycle - idx + 1
            d = i
          end
          break
        end
        cycle[#cycle + 1] = {factor, remainder}
      else
        break
      end
    end
  end
  return d, longest
end

helpers.elapsed_time(function ()
  print(answer())
end)
