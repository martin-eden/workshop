-- Lines input stream

--[[
  Author: Martin Eden
  Last mod.: 2026-07-13
]]

--[[
  Actually it's wrapper over provided base stream.
]]

-- Imports:

local Init =
  function(Me, BaseStream)
    Me.BaseStream = BaseStream
  end

--[[
  Unlike Read() from base streams we have different interface:

  Base Read():

    * Receives number of items to read
    * Returns empty string if stream is over

  This Read():

    * Reads one line per call
    * Returns "false" when stream is over, else returns "true" and string
]]
local Read =
  function(Me)
    -- Naive implementation for first time

    local BaseStream = Me.BaseStream

    local char = BaseStream:Read(1)

    if (char == '') then return false end

    local line = ''

    local newline = '\010'

    while true do
      if (char == '') then break end
      if (char == newline) then break end

      line = line .. char

      char = BaseStream:Read(1)
    end

    return true, line
  end

local Interface =
  {
    Init = Init,
    Read = Read,

    -- Internals:
    BaseStream = { },
  }

-- Export:
return Interface

--[[
  2026-07-13
]]
