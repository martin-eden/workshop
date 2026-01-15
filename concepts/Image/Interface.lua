-- Interface to generic image

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

--[[
  That's interface declaration

  Sole purpose of this file is declare method names (and assume you know
  input/output formats of that methods).

  Similar to [StreamIo].

  Actually is renaming data access methods for multidimensional tables
  to familiar pixels.
]]

local GoGet = request('!.table.GoAndGet')
local GoSet = request('!.table.GoAndSet')

local GetPixel_Dummy =
  -- Traverse table by path and return final node. We hope it's color
  function(self, Path)
    return GoGet(self.Data, Path)
  end

local SetPixel_Dummy =
  -- Traverse table by path and set final node. We hope it's color
  function(self, Path, Color)
    return GoSet(self.Data, Path, Color)
  end

return
  {
    GetPixel = GetPixel_Dummy,
    SetPixel = SetPixel_Dummy,
    Data = {},
  }

-- 2026-01-14
