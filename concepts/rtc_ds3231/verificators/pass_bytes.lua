--[[
  Makes sure we got fixed-length sequence of bytes.

  Sequence indexes span from 0 to 18.
]]

local is_byte = request('!.number.is_byte')

return
  function(data)
    for i = 0, 18 do
      local sub_result, sub_err_msg = is_byte(data[i])
      if not sub_result then
        coroutine.yield(i, sub_err_msg)
      end
    end
  end
