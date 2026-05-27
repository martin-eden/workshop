-- Input stream on file

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

-- Imports:
local is_natural = request('!.number.is_natural')
local open_file_for_reading = request('!.file_system.file.open_for_reading')
local close_file = request('!.file_system.file.close')

local Interface =
  {
    -- [Main]
    Read =
      function(Me, num_bytes)
        assert(is_natural(num_bytes))

        local data_str = Me.File:read(num_bytes)

        -- No end-of-file concept in input stream
        if is_nil(data_str) then data_str = '' end

        return data_str
      end,

    -- [Required extension]
    Open =
      function(Me, pathname)
        local File = open_file_for_reading(pathname)

        if is_nil(File) then return false end

        Me.File = File

        return true
      end,

    -- [Required extension]
    Close =
      function(Me)
        close_file(Me.File)
      end,

    -- [Internal]
    File = nil,
  }

-- Close file at garbage collection
setmetatable(Interface, { __gc = function(Me) Me:Close() end } )

-- Export:
return Interface

--[[
  2024 # # # # #
  2026-05-27
]]
