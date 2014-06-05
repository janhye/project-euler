local helper = require "lib.helper"

-- using pascal triangle solve
local function answer ()
  local count = 0
  local pre = {1, 1} -- (n-1)-th line in pascal triangle
  local nline = {} -- n-th line in pascal triangle
  for n = 2, 100 do
    for i = 1, n + 1 do
      if i == 1 or i == n + 1 then
        nline[i] = 1
      else
        local r = pre[i-1] + pre[i]
        nline[i] = r
        if r > 1000000 then
          count = count + 1
        end
      end
    end
    pre = nline
    nline = {}
  end

  return count
end

helper.elapsed_time(function ()
  print(answer())
end)
