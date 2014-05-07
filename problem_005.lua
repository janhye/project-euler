local helpers = require 'helpers'

local function smallest_multiple ()
  local i = 20
  while true do
    if i % 2 == 0 and
       i % 3 == 0 and
       i % 4 == 0 and
       i % 5 == 0 and
       i % 6 == 0 and
       i % 7 == 0 and
       i % 8 == 0 and
       i % 9 == 0 and
       i % 10 == 0 and
       i % 11 == 0 and
       i % 12 == 0 and
       i % 13 == 0 and
       i % 14 == 0 and
       i % 15 == 0 and
       i % 16 == 0 and
       i % 17 == 0 and
       i % 18 == 0 and
       i % 19 == 0 and
       i % 20 == 0 then
      return i
    end
    i = i + 20
  end
end

helpers.elapsed_time(function ()
  local r = smallest_multiple()
  print(r)
end)
