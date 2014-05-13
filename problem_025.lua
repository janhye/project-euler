local helper = require "lib.helper"

local Bignum = require "lib.bignum"

local function answer ()
  local f1 = Bignum.new(1)
  local f2 = Bignum.new(1)
  local th = 2
  while true do
    local f = f1:add(f2)
    th = th + 1
    if #f:tostring() == 1000 then
      return th
    end
    f1, f2 = f2, f
  end
end

helper.elapsed_time(function ()
  print(answer())
end)
