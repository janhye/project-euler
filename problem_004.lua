local helper = require "lib.helper"

local function is_palindrome (num)
  local num_str = tostring(num)
  local half = math.floor(#num_str / 2)
  local result = true
  for i = 1, half do
    if num_str:sub(i, i) ~= num_str:sub(-i, -i) then
      result = false
    end
  end
  return result
end

local function find_largest_palindrome ()
  local digit = 999
  local result = 0
  local x, y
  for i = digit, 100, -1 do
    for j = digit, 100, -1 do
      local r = i * j
      if is_palindrome(r) and r > result then 
        x = i
        y = j
        result = r
      end
    end
  end
  return result, x, y
end

helper.elapsed_time(function ()
  print(find_largest_palindrome())
end)
