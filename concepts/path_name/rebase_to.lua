-- Rebase directory name to another base directory

--[[
  Author: Martin Eden
  Last mod.: 2026-08-10
]]

--[[
  Contract

  Input is two pathname strings:

    1 [s] dest_dir -- base directory to rebase onto
    2 [s] dir_to_rebase -- pathname to rebase

  Output is a string:

    * All ".." segments are dropped from <dir_to_rebase>.
    * Leading "" (absolute marker) is dropped from <dir_to_rebase>,
      since after rebasing it's no longer absolute on its own.
    * Trailing "" (directory marker) of <dest_dir> is
      dropped, since it becomes a middle segment.
    * Trailing "" (directory marker) of <dir_to_rebase>, if any,
      is kept at the end of result.
    * Remaining segments of <dest_dir> and <dir_to_rebase>
      are concatenated and serialized back to a pathname string.
]]

-- Imports:
local Syntels = request('Syntels')
local pathname_from_str = request('pathname_from_str')
local is_directory = request('is_directory')
local is_absolute = request('is_absolute')
local add_list = request('!.concepts.list.add_list')
local pathname_to_str = request('pathname_to_str')

local tbl_remove = table.remove

local upper_dir = Syntels.upper_dir

local rebase_to =
  function(dest_dir, dir_to_rebase)
    assert_string(dest_dir)
    assert_string(dir_to_rebase)

    local DestNames = pathname_from_str(dest_dir)
    local MovedNames = pathname_from_str(dir_to_rebase)

    if is_directory(DestNames) then
      tbl_remove(DestNames, #DestNames)
    end

    if is_absolute(MovedNames) then
      tbl_remove(MovedNames, 1)
    end

    do
      local index = 1
      while (index <= #MovedNames) do
        if (MovedNames[index] == upper_dir) then
          tbl_remove(MovedNames, index)
        else
          index = index + 1
        end
      end
    end

    local Result = { }
    add_list(Result, DestNames)
    add_list(Result, MovedNames)

    return pathname_to_str(Result)
  end

-- Export:
return rebase_to

--[[
  Examples (Itness format)

    ( deploy  /abc ) -> deploy/abc
    ( deploy/ sub/dir/ ) -> deploy/sub/dir/
    ( deploy ../../docs/readme.md ) -> deploy/docs/readme.md
]]

--[[
  2026-08-10
]]
