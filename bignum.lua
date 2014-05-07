local string = string
local math = math
local table = table

local Bignum = {}

function Bignum.new (digit)
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
  Bignum.__index = Bignum
  setmetatable(o, Bignum)

  local c = 1
  repeat
    local n = tonumber(digit:sub(-c - 8, -c))
    if n == 0 and #o.data ~= 0 then break end
    o.data[#o.data + 1] = n
    c = c + 9
  until c > #digit

  return o
end

function Bignum:add (n)
  n = n or 0
  local b = Bignum.new()

  if type(n) == "number" or type(n) == "string" then
    n = Bignum.new(n)
  end

  local l = math.max(#self.data, #n.data)
  local extra
  local num
  for i = 1, l do
    b.data[i] = b.data[i] or 0
    if i > #n.data then
      num = self.data[i] + b.data[i]
    elseif i > #self.data then
      num = n.data[i] + b.data[i]
    else
      num = self.data[i] + n.data[i] + b.data[i]
    end

    extra = num - 10 ^ b.bits
    if extra >= 0 then
      b.data[i] = extra
      b.data[i + 1] = 1
    else
      b.data[i] = num
    end
  end
  return b
end

function Bignum:tostring ()
  local buf = {}
  for i = #self.data, 1, -1 do 
    buf[#buf + 1] = self.data[i]
  end
  return table.concat(buf)
end

return Bignum
