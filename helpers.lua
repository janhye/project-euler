local m = {}

local os = os

function m.elapsed_time (fn)
  local t = os.clock()
  fn()
  local elapsed = os.clock() - t
  print(string.format("elapsed time: %.2fms\n", elapsed * 1000))
  return elapsed
end

return m
