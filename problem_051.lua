local helper = require "lib.helper"
local split_digits = helper.split_digits
local digits_to_number = helper.digits_to_number
local primes = helper.primes
local huge = math.huge
local combinegen = helper.combinegen
local sort = table.sort

local function clone (t)
  local r = {}
  for k, v in pairs(t) do
    r[k] = v
  end

  return r
end

local function answer ()
  local ps_set = {}
  for p in primes() do
    ps_set[p] = true
    if p > 1000000 then
      break
    end
  end

  local r
  for i = 10, huge do
    local digits = split_digits(i)
    for j = 1, #digits - 1 do
      for c in combinegen(digits, j) do
        -- replace c in digits with 0-9
        local dts = clone(digits)
        local idxs = {}
        for _, v in ipairs(c) do
          for idx, d in ipairs(digits) do
            if d == v then
              idxs[#idxs+1] = idx
              break
            end
          end
        end

        local ps = {}
        for k = 0, 9 do
          for _, v in ipairs(idxs) do
            dts[v] = k
          end

          -- the highest bit can not replace 0
          if dts[#dts] ~= 0 then
            local n = digits_to_number(dts)
            if ps_set[n] then
              ps[#ps+1] = n
            end
          end
        end
        
        if #ps == 8 then
          r = ps
          goto finish
        end
      end
    end
  end
  ::finish::

  sort(r)
  for _, v in ipairs(r) do
    io.write(v, ", ")
  end
  io.write("\n")

  return r[1]
end

helper.elapsed_time(function ()
  print(answer())
end)
