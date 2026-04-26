-- Parse pathname string to categorized table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
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
  * .HostDir for relative paths starts with "."
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
    local path = split_string(path_name, sep)

    setmetatable(
      path,
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

    do
      local index = 2
      local current_item
      while (index <= #path - 1) do
        current_item = path[index]
        if
          (current_item == empty) or
          (current_item == self_dir)
        then
          table.remove(path, index)
        else
          index = index + 1
        end
      end
    end

    local is_directory =
      (path.last_node == self_dir) or
      (path.last_node == upper_dir) or
      (path.last_node == empty)

    if
      (path.first_node == '.') and
      (path[2] == '..')
    then
      table.remove(path, 1)
    end

    if
      (path.last_node == empty) and
      (#path >= 2)
    then
      table.remove(path, #path)
    end

    while
      (path.last_node == self_dir) and
      (#path >= 2)
    do
      table.remove(path, #path)
    end

    local host_dir_name
    do
      if
        (path.first_node ~= empty) and
        (path.first_node ~= self_dir) and
        (path.first_node ~= upper_dir)
      then
        table.insert(path, 1, self_dir)
      end
      if
        (#path == 1) and
        (path.first_node ~= empty) and
        (path.first_node ~= upper_dir)
      then
        table.insert(path, 1, self_dir)
      end
      host_dir_name = table.concat(path, sep, 1, #path - 1)
      if
        (host_dir_name == empty) and
        (path.first_node ~= empty)
      then
        -- Zen question: what is the "upper dir" for ".." ?
        host_dir_name = self_dir
      end
      host_dir_name = host_dir_name .. sep
    end

    if
      (#path == 2) and
      (path.first_node == self_dir) and
      (path.last_node == self_dir)
    then
      table.remove(path, #path)
    end

    local full_name = table.concat(path, sep)
    if is_directory then
      full_name = full_name .. sep
    end

    local leaf_name = path.last_node
    if (leaf_name == empty) then
      leaf_name = self_dir
    end

    local Result =
      {
        HostDir = host_dir_name,
        Name = leaf_name,
        FullName = full_name,
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

    /.
      Same as for "/"

    ./
      FullName = './'
      HostDir = './'
      Name = '.'

    .
      Same as for "./"

    ../
      FullName = '../'
      HostDir = './'
      Name = '..'

    ..
    ./..
      Same as for "../"

    /..
      FullName = '/../'
      HostDir = '/'
      Name = '..'

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
]]
