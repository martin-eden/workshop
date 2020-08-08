--[[
  Checks that given integer fits in byte range.
]]

return
  function(n)
    local result, err_msg = is_integer(n)
    if result then
      result = (n == n & 0xFF)
      if not result then
        err_msg =
          ('Given integer %d is not in byte range [0, 255].'):
          format(n)
      end
    end
    return result, err_msg
  end
