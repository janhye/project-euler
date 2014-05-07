local helpers = require 'helpers'

local function prime_factors (number)
  local factor = 2
  local prime_factors = {}
  local res = number
  repeat
    if res % factor == 0 then
      table.insert(prime_factors, factor)
      res = res / factor
    else
      factor = factor + 1
    end
  until res == 1
  return prime_factors
end

helpers.elapsed_time(function ()
  local factors = prime_factors(600851475143)
  print(table.concat(factors, ', '))
  print('MAX: ' .. factors[#factors])
end)
