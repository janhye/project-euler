local helper = require "lib.helper"

local bxor
if jit then
  bxor = bit.bxor
else
  bxor = bit32.bxor
end

local open, write = io.open, io.write
local gmatch, char = string.gmatch, string.char
local tonumber, ipairs = tonumber, ipairs

local function table_default (t, d)
  setmetatable(t, {__index = function () return d end})
  return t
end

-- 频率分析法
local function analysis (data)
  local n = 3
  local buf = {table_default({}, 0), 
               table_default({}, 0), 
               table_default({}, 0)}
  local keys = {}
  for i, d in ipairs(data) do
    local m = (i - 1) % n + 1
    buf[m][d] = buf[m][d] + 1
    if buf[m][d] > buf[m][keys[m]] then
      keys[m] = d
    end
  end

  return keys
end

local function answer ()
  local file = open("problem_059_cipher1.txt", "r")
  local s = file:read("*a")
  file:close()

  local data = {}
  for b in gmatch(s, "%d+") do
    data[#data+1] = tonumber(b)
  end

  local keys = {}
  for i, k in ipairs(analysis(data)) do
    -- space ASCII is 32
    keys[i] = bxor(k, 32)
  end

  -- decryption
  local n = #keys
  local sum = 0
  for i, d in ipairs(data) do
    local m = (i - 1) % n + 1
    local r = bxor(d, keys[m])
    sum = sum + r
    write(char(r))
  end
  write("\n\n")

  return sum
end

helper.elapsed_time(function ()
  print(answer())
end)
