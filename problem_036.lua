local helper = require "lib.helper"
local tostring = tostring
local byte = string.byte

local function tobinary (n)
  local mod
  local bin = {}
  repeat
    mod = n % 2
    n = (n - mod) / 2
    bin[#bin+1] = mod
  until n == 0
  return bin
end

local function answer ()
  local sum = 0
  for i = 1, 1000000 - 1 do
    local is_palindromic_base_10 = true
    local s = tostring(i)
    for j = 1, #s / 2 do
      if byte(s, j, j) ~= byte(s, -j, -j) then
        is_palindromic_base_10 = false
        break
      end
    end
    
    if is_palindromic_base_10 then
      local is_palindromic_base_2 = true
      local is_palindromic_both = true
      local bin = tobinary(i)
      for j = 1, #bin / 2 do
        if bin[j] ~= bin[#bin - j + 1] then
          is_palindromic_base_2 = false
          break
        end
      end

      if not is_palindromic_base_2 then
        is_palindromic_both = false
      end

      if is_palindromic_both then
        sum = sum + i
      end
    end
  end

  return sum
end

helper.elapsed_time(function ()
  print(answer())
end)
