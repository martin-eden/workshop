--[[
  Makes sure we got fixed-length sequence of bytes.

  Sequence indexes span from 1 to 19.
]]

local is_byte = request('!.number.is_byte')

return
  function(data)
    for i = 1, 19 do
      local sub_result, sub_err_msg = is_byte(data[i])
      if not sub_result then
        coroutine.yield(i, sub_err_msg)
      end
    end
  end
