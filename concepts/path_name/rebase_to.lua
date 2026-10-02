-- Rebase directory name to another base directory

--[[
  Author: Martin Eden
  Last mod.: 2026-10-03
]]

--[[
  Contract

  Input is two pathname strings:

    1 [s] dest_dir -- base directory to rebase onto
    2 [s] pathname -- pathname to rebase

  Output is a string:

    * ".." segments in <pathname> move the write position back
      one segment (overwriting it), clamped at the start, so
      nothing escapes <dest_dir>.
    * Absolute <pathname> is treated like local.
    * Processed segments of <dest_dir> and <pathname>
      are concatenated and serialized back to a pathname string.
]]

--[[
  Examples (Itness format)

    ( deploy/ sub/dir/ ) -> deploy/sub/dir/
    ( deploy a/../b ) -> deploy/b
    ( deploy a/../../b ) -> deploy/b
    ( deploy /abc ) -> deploy/abc
]]

local pathname_from_str = request('pathname_from_str')
local tbl_remove = table.remove
local RangePoint = request('!.concepts.RangePoint')
local upper_dir = request('Syntels').upper_dir
local add_list = request('!.concepts.list.add_list')
local pathname_to_str = request('pathname_to_str')

-- Export:
return
  function(dest_dir, pathname)
    assert_string(dest_dir)
    assert_string(pathname)

    local DestNames = pathname_from_str(dest_dir)
    local MovedNames = pathname_from_str(pathname)

    -- Remove directory marker
    if (DestNames[#DestNames] == '') then
      tbl_remove(DestNames, #DestNames)
    end

    -- Remove absolute marker
    if (MovedNames[1] == '') then
      tbl_remove(MovedNames, 1)
    end

    do
      local Cursor = RangePoint.create()
      Cursor:SetMinValue(1)
      Cursor:SetMaxValue(#MovedNames + 1)
      Cursor:SetValue(1)

      for name_index = 1, #MovedNames do
        local cursor_pos = Cursor:GetValue()
        if (MovedNames[name_index] == upper_dir) then
          Cursor:SetValue(cursor_pos - 1)
        else
          MovedNames[cursor_pos] = MovedNames[name_index]
          Cursor:SetValue(cursor_pos + 1)
        end
      end

      for name_index = Cursor:GetValue(), #MovedNames do
        MovedNames[name_index] = nil
      end
    end

    local Result = { }
    add_list(Result, DestNames)
    add_list(Result, MovedNames)

    return pathname_to_str(Result)
  end

--[[
  2026 #
  2026-10-03
]]
