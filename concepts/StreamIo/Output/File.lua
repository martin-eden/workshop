-- Output stream on file

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

-- Imports:
local open_file_for_writing = request('!.file_system.file.open_for_writing')
local close_file = request('!.file_system.file.close')

local Interface =
  {
    -- [Main]
    Write =
      function(Me, data_str)
        assert_string(data_str)
        assert(data_str ~= '')

        Me.File:write(data_str)
      end,

    -- [Required extension]
    Open =
      function(Me, pathname)
        local File = open_file_for_writing(pathname)

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
    File = 0,
  }

-- Close file at garbage collection
setmetatable(Interface, { __gc = function(Me) Me:Close() end } )

-- Export:
return Interface

--[[
  2024 # # # # #
  2026-05-27
]]
