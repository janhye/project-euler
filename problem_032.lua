local helper = require "lib.helper"
local math = math
local table = table

local function answer ()

  local function getnumber (t)
    local n = 0
    for i, v in ipairs(t) do
      n = n + v * 10 ^ (i - 1)
    end
    return n
  end

  local function diff (t1, t2)
    if #t1 < #t2 then t1, t2 = t2, t1 end
    local res = {}
    for _, v1 in ipairs(t1) do
      local found = false
      for _, v2 in ipairs(t2) do
        if v1 == v2 then 
          found = true
          break
        end
      end
      if not found then
        table.insert(res, v1)
      end
    end
    return res
  end

  local function is_pandigital_product (t, n) 
    local set = {}
    local d
    local r = n
    repeat
      d = r % 10
      if set[d] ~= nil then return false end
      
      local found = false
      for _, v in ipairs(t) do
        if v == d then 
          found = true 
          break
        end
      end
      if not found then return false end

      set[d] = true
      r = math.floor(r / 10)
    until r == 0

    return true
  end

  local a = {1,2,3,4,5,6,7,8,9}
  local sum = 0
  local result_t = {}
  for i = 1, 2 do
    for c in helper.combinegen(a, i) do
      local r = diff(a, c)
      for p in helper.permgen(c) do
        local x = getnumber(p)
        for c in helper.combinegen(r, 5 - i) do
          local r2 = diff(r, c)
          for p in helper.permgen(c) do
            local y = getnumber(p)
            local product = x * y
            if is_pandigital_product(r2, product) then
              result_t[product] = x .. " * " .. y
            end
          end
        end
      end
    end
  end

  for k, v in pairs(result_t) do
    sum = sum + k
    print(v .. " = " .. k)
  end

  return sum
end

helper.elapsed_time(function ()
  print(answer())
end)
