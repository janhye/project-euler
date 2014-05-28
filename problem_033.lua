local helper = require "lib.helper"

local lowest_common_terms = helper.lowest_common_terms

local function answer ()
  local res = {}

  local function split_number (n)
    local m = n % 10
    return (n - m) / 10, m
  end

  for d = 12, 99 do
    if d % 10 ~= 0 then
      local d_tens, d_units = split_number(d)
      for n = d_tens + 10, d - 1, 10 do
        local n_tens = split_number(n)
        if n / d == n_tens / d_units then
          res[#res+1] = {n, d}
        end
      end
      if d_tens >= d_units then
        for n = d_units * 10 + 1, d - 1 do
          local _, n_units = split_number(n)
          if n / d == n_units / d_tens then
            res[#res+1] = {n, d}
          end
        end
      end
    end
  end

  local n, d = 1, 1
  for _, v in ipairs(res) do
    n = n * v[1]
    d = d * v[2]
  end

  local n, d = lowest_common_terms(n, d)
  return d
end

helper.elapsed_time(function ()
  print(answer())
end)
