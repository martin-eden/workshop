-- Parse pathname string to list of names

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

--[[
  Contract

  * Empty pathname string is not accepted
  * Returned list always contains at least two items
  * If pathname is absolute then first item is ""
  * If pathname is directory then last item is ""
]]

-- Imports:
local split_string = request('!.string.split')

local sep = '/'
local empty = ''
local self_dir = '.'
local upper_dir = '..'

--[[
  Parses string with Unix pathname. Returns table
]]
local pathname_from_str =
  function(path_name)
    assert_string(path_name)
    assert(path_name ~= '', 'Please pass not empty path_name')

    path_name = path_name .. sep
    local Path = split_string(path_name, sep)

    do
      local index = 2
      local current_item
      while (index <= #Path - 1) do
        current_item = Path[index]
        if
          (current_item == empty) or
          (current_item == self_dir)
        then
          table.remove(Path, index)
        else
          index = index + 1
        end
      end
    end

    setmetatable(
      Path,
      {
        __index =
          function(table, key)
            if (key == 'first_node') then
              return table[1]
            elseif (key == 'last_node') then
              return table[#table]
            end
          end,
      }
    )

    if (Path.first_node == self_dir) and (#Path >= 3) then
      table.remove(Path, 1)
    end

    if (Path.last_node == self_dir) and (#Path >= 2) then
      Path[#Path] = ''
    end

    local is_directory =
      (Path.last_node == self_dir) or
      (Path.last_node == upper_dir) or
      (Path.last_node == empty)

    if
      is_directory and
      (
        (Path.last_node ~= empty) or
        (#Path == 1)
      )
    then
      table.insert(Path, '')
    end

    --[[
      Now <Path> contains at least two entries

      If first entry is "" then it's absolute path.
      If last entry is "" then it's directory.
    ]]

    return Path
  end

-- Export:
return pathname_from_str

--[[
  Notes

    * POSIX pathnames are elegant

      Don't treat them as strings. Treat them as slash-separated
      strings list.

    * Empty string as pathname is illegal in POSIX

      This code will process it as "/". But empty string is stupid,
      so empty string is under assert().

    * ".." element

      It does not interpret "a/b/.." as "a/" because "b" may be
      symlink to another directory.

  Examples

    a
      { 'a' }

    a/
      { 'a', '' }

    /a
      { '', 'a' }

    /a/
      { '', 'a', '' }

    a/b
      { 'a', 'b' }

    /
      { '', '' }

    /.
      Same as for "/"

    .
      { '.', '' }

    ./
      Same as for "."

    ..
      { '..', '' }

    ../
    ./..
      Same as for ".."

    /..
      { '', '..', '' }

    ././..//a/./.
      { '..', 'a', '' }
]]

--[[
  2016-09
  2018-06
  2026-04 # # # #
  2026-06-11
  2026-06-12
]]
