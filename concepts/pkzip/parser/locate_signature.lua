--[[
  Find signature near end of data stream.
  If found, locate to start of it and return true.
  Else return nothing.

  Changes stream position.
]]

local max_offs = 64 * 1024 + 20

return
  function(stream, signature)
    local is_found = false
    stream:set_position(stream:get_length() - max_offs)
    while stream:match_regexp(signature) do
      is_found = true
    end
    if is_found then
      stream:set_relative_position(-#signature)
    end
    return is_found
  end
