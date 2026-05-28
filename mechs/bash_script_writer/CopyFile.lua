-- Add file copy operation to queue

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

--[[
  <FilesToCopy> structure

    [s] src_name -- source file pathname
    [s] dest_name -- destination file pathname
]]

-- Imports:
local normalize_name = request('!.file_system.file.normalize_name')
local add_to_list = request('!.concepts.list.add_item')

local CopyFile =
  function(Me, src_name, dest_name)
    assert_string(src_name)
    assert_string(dest_name)

    add_to_list(
      Me.FilesToCopy,
      {
        src_name = normalize_name(src_name),
        dest_name = normalize_name(dest_name),
      }
    )
  end

-- Export:
return CopyFile

--[[
  2018
  2026-05-28
]]
