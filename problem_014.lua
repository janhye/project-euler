local helpers = require 'helpers'

local function answer ()
  local longest_chain = 1
  local term
  for i = 2, 1000000 do
    local chain = 1
    local n = i
    while n ~= 1 do
      chain = chain + 1
      if n % 2 == 0 then
        n = n / 2
      else
        n = 3 * n + 1
      end
    end

    if chain > longest_chain then 
      longest_chain = chain
      term = i
    end
  end

  return term, longest_chain
end

helpers.elapsed_time(function ()
  print(answer())
end)
