-- Rebase directory name to another base directory

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
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
local range_point = request('!.concepts.range_point')
local upper_dir = request('Syntels').upper_dir
local add_list = request('!.concepts.list.add_list')
local pathname_to_str = request('pathname_to_str')

return
  function(dest_dir, pathname)
    assert_string(dest_dir)
    assert_string(pathname)

    local dest_names = pathname_from_str(dest_dir)
    local moved_names = pathname_from_str(pathname)

    -- Remove directory marker
    if (dest_names[#dest_names] == '') then
      tbl_remove(dest_names, #dest_names)
    end

    -- Remove absolute marker
    if (moved_names[1] == '') then
      tbl_remove(moved_names, 1)
    end

    do
      local cursor = range_point.create(1, #moved_names + 1)

      for name_index = 1, #moved_names do
        local cursor_pos = cursor:get_value()
        if (moved_names[name_index] == upper_dir) then
          cursor:set_value(cursor_pos - 1)
        else
          moved_names[cursor_pos] = moved_names[name_index]
          cursor:set_value(cursor_pos + 1)
        end
      end

      for name_index = cursor:get_value(), #moved_names do
        moved_names[name_index] = nil
      end
    end

    local result = { }
    add_list(result, dest_names)
    add_list(result, moved_names)

    return pathname_to_str(result)
  end

--[[
  2026 #
  2026-10-03
]]
