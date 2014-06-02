local helper = require "lib.helper"
local primes = helper.primes
local permgen = helper.permgen
local ipairs = ipairs
local sort = table.sort
local concat = table.concat

local function split_number (n)
  local digits = {}
  repeat
    local m = n % 10
    n = (n - m) / 10
    digits[#digits+1] = m
  until n == 0

  return digits
end

local function digits_to_number (digits)
  local n = 0
  for i, v in ipairs(digits) do
    n = n + v * 10 ^ (i - 1)
  end
  
  return n
end

local function answer ()
  local ps = {}
  local ps_set = {}
  for p in primes() do
    if p > 10000 then break end

    if p > 1000 then
      ps[#ps+1] = p
      ps_set[p] = true
    end
  end

  local res = {}
  local buf = {}
  for _, v in ipairs(ps) do
    if not buf[v] then
      local digits = split_number(v)
      local ps_perm = {}
      for perm in permgen(digits) do
        local n = digits_to_number(perm)
        if ps_set[n] and not buf[n] then
          ps_perm[#ps_perm+1] = n
          buf[n] = true
        end
      end

      if #ps_perm >= 3 then
        sort(ps_perm)
        for i = 1, #ps_perm - 2 do
          for j = i + 1, #ps_perm - 1 do
            local n = ps_perm[j] + (ps_perm[j] - ps_perm[i])
            for k = j + 1, #ps_perm do
              if n == ps_perm[k] then
                res[#res+1] = {ps_perm[i], ps_perm[j], ps_perm[k]}
                break
              end
            end
          end
        end
      end
    end
  end

  for _, v in ipairs(res) do
    print(concat(v))
  end
end

helper.elapsed_time(function ()
  print(answer())
end)
