local helper = require "lib.helper"

local function answer ()
  local ways = {[0] = 1}
  local sum = 200
  helper.set_default(ways, 0)
  local coins = {1, 2, 5, 10, 20, 50, 100, 200}
  for _, coin in ipairs(coins) do
    for i = coin, sum do 
      ways[i] = ways[i] + ways[i - coin]
    end
  end

  return ways[sum]
end

helper.elapsed_time(function ()
  print(answer())
end)
