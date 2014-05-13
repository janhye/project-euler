local helper = require "lib.helper"

local function sum_square_diff ()
  local sum_of_the_squares = 0
  local sum = 0
  for i = 1, 100 do
    sum_of_the_squares = sum_of_the_squares + i ^ 2
    sum = sum + i
  end

  return sum ^ 2 - sum_of_the_squares
end

helper.elapsed_time(function ()
  local r = sum_square_diff()
  print(r)
end)
