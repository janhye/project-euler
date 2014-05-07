local helpers = require 'helpers'
local table = table

local function prime_number_at (target_st)
  local prime_numbers = {2}
  local num = 3
  while true do
    local is_prime_number = true
    for i = 1, #prime_numbers do
      if num % prime_numbers[i] == 0 then
        is_prime_number = false
        break
      end
    end
    if is_prime_number then
      if #prime_numbers + 1 == target_st then
        return num
      else
        table.insert(prime_numbers, num)
      end
    end
    num = num + 1
  end
end

helpers.elapsed_time(function ()
  local r = prime_number_at(10001)
  print(r)
end)
