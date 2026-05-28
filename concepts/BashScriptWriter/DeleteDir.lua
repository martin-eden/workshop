-- Add a directory removal operation to queue

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

--[[
  <DirsToDelete> structure

    Strings list with directory names.
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')

local DeleteDir =
  function(Me, dir_name)
    assert_string(dir_name)

    add_to_list(Me.DirsToDelete, dir_name)
  end

-- Export:
return DeleteDir

--[[
  2019
  2026-05-28
]]
