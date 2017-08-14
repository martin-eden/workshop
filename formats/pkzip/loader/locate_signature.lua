--[[
  This is PKZIP format specific function. Not suitable for general use.

  Find signature near end of data stream.
  If found, locate to start of it and return true.
  Else return nothing.

  Changes stream position.
]]

local max_offs = 64 * 1024 + 20

return
  function(self, signature)
    in_stream = self.in_stream
    in_stream:set_position(in_stream:get_length() - max_offs)
    if in_stream:match_regexp(signature) then
      in_stream:set_relative_position(-#signature)
      return true
    end
  end
