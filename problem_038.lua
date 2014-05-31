local helper = require "lib.helper"

local tostring = tostring
local byte = string.byte
local concat = table.concat

local function clear_buf (buf)
  for j = 1, #buf do
    buf[j] = nil
  end
end

local function answer ()
  local digits = "123456789"
  local largest = "123456789"
  local buf = {}
  for i = 1, 9876 do
    clear_buf(buf)
    local len = 0
    for j = 1, 9 do
      if len >= 9 then
        break
      end
      local s = tostring(i * j)
      buf[#buf+1] = s
      len = len + #s
    end

    if len == 9 then
      local is_pandigital = true
      local r = concat(buf)
      for i = 1, #digits do
        local found = false
        for j = 1, #r do
          if byte(digits, i) == byte(r, j) then
            found = true
            break
          end
        end

        if not found then
          is_pandigital = false
          break
        end
      end

      if is_pandigital then
        if r > largest then
          largest = r
        end
      end
    end
  end

  return largest
end

helper.elapsed_time(function ()
  print(answer())
end)
