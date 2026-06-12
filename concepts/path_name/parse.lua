-- Parse pathname string to categorized table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-11
]]

--[[
  Pathnames in Unix can be obscure: ".///.//a/.//" is same as "a/"

  Here is function to parse them.

  Result structure

    {
      HostDir -- [s] Directory containing leaf file. Always ends with "/"
      Name -- [s] Leaf file of directory. Never has "/"
      FullName -- [s] Directory + Name. Ends with "/" if leaf is directory
    }
]]

--[[
  Contract

  * .HostDir always ends with "/"
  * .Name never contains "/"
  * .HostDir for absolute paths starts with "/"
]]

-- Imports:
local split_string = request('!.string.split')

--[[
  Parses string with Unix pathname. Returns table
]]
local parse_pathname =
  function(path_name)
    assert_string(path_name)
    assert(path_name ~= '', 'Please pass not empty path_name')

    local sep = '/'
    local self_dir = '.'
    local upper_dir = '..'
    local empty = ''

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

    local is_absolute =
      (Path.first_node == empty)

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
      If last entry is "" or ".." then it's directory.
    ]]

    local full_name = table.concat(Path, sep)

    local host_dir_name
    do
      local host_dir_end_idx
      if is_directory then
        host_dir_end_idx = #Path - 2
      else
        host_dir_end_idx = #Path - 1
      end
      host_dir_name = table.concat(Path, sep, 1, host_dir_end_idx)
      if (host_dir_name == empty) then
        --[[
          Cases when we can come here: ".", "..", "/", "abc".
          We need to provide host dir for them.
          Zen question: what is the name of "parent dir" for ".."?
          That's why we're using name "host", not "parent".
        ]]
        if is_absolute then
          host_dir_name = empty
        else
          host_dir_name = self_dir
        end
      end
      host_dir_name = host_dir_name .. sep
    end

    local leaf_name
    if is_directory then
      leaf_name = Path[#Path - 1]
    else
      leaf_name = Path[#Path]
    end

    if (leaf_name == empty) then
      leaf_name = self_dir
    end

    local Result =
      {
        HostDir = host_dir_name,
        Name = leaf_name,
        FullName = full_name,
        Path = Path,
      }

    return Result
  end

-- Export:
return parse_pathname

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

    /
      FullName = '/'
      HostDir = '/'
      Name = '.'
      Path = { '', '' }

    /.
      Same as for "/"

    .
      FullName = './'
      HostDir = './'
      Name = '.'
      Path = { '.', '' }

    ./
      Same as for "."

    ..
      FullName = '../'
      HostDir = './'
      Name = '..'
      Path = { '..', '' }

    ../
    ./..
      Same as for ".."

    /..
      FullName = '/../'
      HostDir = '/'
      Name = '..'
      Path = { '', '..', '' }

    a/b
      FullName = './a/b'
      HostDir = './a/'
      Name = 'b'

    a/b/
      FullName = './a/b/'
      HostDir = './a/'
      Name = 'b'

    ././..//a/./.
      FullName = '../a/'
      HostDir = '../'
      Name = 'a'
]]

--[[
  2016-09
  2018-06
  2026-04-22
  2026-04-23
  2026-04-24
  2026-04-26
  2026-06-11
]]
