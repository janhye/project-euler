local string = string
local math = math
local table = table
--local bit32 = bit32

local BignumDec = {}

function BignumDec.new (digit)
  digit = digit or 0
  if type(digit) == "string" then 
    local _, e = string.find(digit, "%d+")
    if e ~= #digit then 
      digit = 0 
    end
  elseif type(digit) == "number" then
    digit = tostring(digit)
  else
    error("digit type error")
  end

  local o = {
    data = {}, 
    bits = 9 
  }
  BignumDec.__index = BignumDec
  setmetatable(o, BignumDec)

  local c = 1
  repeat
    local n = tonumber(digit:sub(-c - 8, -c))
    if n == 0 and #o.data ~= 0 then break end
    o.data[#o.data + 1] = n
    c = c + 9
  until c > #digit

  return o
end

function BignumDec:add (n, modify_self)
  n = n or 0

  local b
  if modify_self == true then
    b = self
  else
    b = BignumDec.new()
  end

  if type(n) == "number" or type(n) == "string" then
    n = BignumDec.new(n)
  end

  local l = math.max(#self.data, #n.data)
  local extra = 0
  local num
  for i = 1, l do
    if i > #n.data then
      num = self.data[i] + extra
    elseif i > #self.data then
      num = n.data[i] + extra
    else
      num = self.data[i] + n.data[i] + extra
    end

    local minus = num - 10 ^ b.bits
    if minus >= 0 then
      b.data[i] = minus
      extra = 1
    else
      b.data[i] = num
      extra = 0
    end
  end

  if extra > 0 then
    b.data[l + 1] = extra
  end

  return b
end

function BignumDec:tostring ()
  local buf = {}
  for i = #self.data, 1, -1 do 
    local s = tostring(self.data[i])
    if i < #self.data then
      local ext = self.bits - #s
      for i = 1, ext do
        buf[#buf + 1] = "0"
      end
    end
    buf[#buf + 1] = s
  end
  return table.concat(buf)
end

function BignumDec:div2 (modify_self)
  local b, mod
  if modify_self == true then
    b = self
  else
    b = BignumDec.new()
  end

  mod = self.data[1] % 2

  for i = 1, #self.data do
    if i > 1 then
      if self.data[i] % 2 == 1 then
        b.data[i - 1] = b.data[i - 1] + 5 * (10 ^ (b.bits - 1))
      end
    end

    if i == #self.data and self.data[i] == 1 then
      if i == 1 then
        b.data[i] = 0
      else
        b.data[i] = nil
      end
    else
      b.data[i] = math.floor(self.data[i] / 2)
    end
  end

  return mod, b
end

function BignumDec:is_zero ()
  if #self.data == 1 and self.data[1] == 0 then
    return true
  else
    return false
  end
end

-- 2 ^ n
function BignumDec.pow2 (n)
  local b
  if n == 0 then
    b = BignumDec.new(1)
  elseif n >= 1 then
    b = BignumDec.new(2)
  end

  for i = 2, n do
    b = b:add(b, true)
  end
  return b
end

--[[-------------------------------------------------------------------------

local BignumBin = {}

function BignumBin.new (digit)
  digit = digit or 0
  if type(digit) == "string" then 
    local _, e = string.find(digit, "%d+")
    if e ~= #digit then 
      digit = 0 
    end
  elseif type(digit) == "number" then
    digit = tostring(digit)
  else
    error("digit type error")
  end

  local o = {
    data = {}, 
    bits = 31
  }
  BignumBin.__index = BignumBin
  setmetatable(o, BignumBin)

  local dec = BignumDec.new(digit)
  local mod
  local d = 0
  local i = 1
  repeat
    mod = dec:div2(true)
    if mod == 1 then
      d = d + 2 ^ (i - 1)
    end
    if i % o.bits == 0 then
      o.data[#o.data + 1] = d
      d = 0
      i = 1
    else
      i = i + 1
    end
  until dec:is_zero()
  if d ~= 0 then
    o.data[#o.data + 1] = d
  end

  return o
end

function BignumBin:tostring ()
  local sum = BignumDec.new(0)
  for k, v in ipairs(self.data) do
    for i = 1, self.bits do
      if bit32.band(self.data[k], 2 ^ (i - 1)) ~= 0 then
        sum:add(BignumDec.pow2((k - 1) * self.bits + i - 1), true)
      end
    end
  end
  return sum:tostring()
end

function BignumBin:add (n, modify_self)
  n = n or 0

  local b
  if modify_self == true then
    b = self
  else
    b = BignumBin.new()
  end

  if type(n) == "number" or type(n) == "string" then
    n = BignumBin.new(n)
  end

  local l = math.max(#self.data, #n.data)
  local extra = 0
  local num
  for i = 1, l do
    if i > #n.data then
      num = self.data[i] + extra
    elseif i > #self.data then
      num = n.data[i] + extra
    else
      num = self.data[i] + n.data[i] + extra
    end

    local minus = num - 2 ^ (b.bits + 1)
    if minus >= 0 then
      b.data[i] = minus
      extra = 1
    else
      b.data[i] = num
      extra = 0
    end
  end

  if extra > 0 then
    b.data[l + 1] = extra
  end

  return b
end
--]]

return BignumDec
