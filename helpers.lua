local helpers = {}

local os = os

function helpers.elapsed_time (fn)
  local t = os.clock()
  fn()
  local elapsed = os.clock() - t
  print(string.format("elapsed time: %.2fms\n", elapsed * 1000))
  return elapsed
end

function helpers.remove_at (t, n)
  local v = t[n]
  for i = n, #t do
    if i == #t then 
      t[i] = nil
    else
      t[i] = t[i + 1]
    end
  end
  return v
end

function helpers.factorial (n)
  local f = 1
  for i = 1, n do
    f = f * i
  end
  return f
end

function helpers.find (array, fn)
  for i, v in ipairs(array) do 
    if fn(v) then
      return i, v
    end
  end
  return nil, nil
end

return helpers
