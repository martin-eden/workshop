-- Parse pathname string to categorized table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

--[[
  Pathnames in Unix can be obscure: ".///.//a/.//" is same as "a/"

  Here is function to parse them.

  It provides handy invariant: .Directory + .Name == Canonical path

  Also it provides list of node names in path.

  And flags that
    * path is absolute
    * ends on directory
]]

-- Imports:
local starts_with = request('!.string.starts_with')
local ends_with = request('!.string.ends_with')
local split_string = request('!.string.split')

local cleanup_pathname =
  function(path_name)
    -- Replace "//" with "/"
    path_name = string.gsub(path_name, '//+', '/')

    -- Strip "./" from start
    repeat
      local num_repl
      path_name, num_repl = string.gsub(path_name, '^%./', '')
    until (num_repl == 0)

    -- Strip "./" from middle. Actually we are replacing "/./" to "/"
    repeat
      local num_repl
      path_name, num_repl = string.gsub(path_name, '/%./', '/')
    until (num_repl == 0)

    -- Replace tail "/." to "/"
    path_name = string.gsub(path_name, '/%.$', '/')

    return path_name
  end

--[[
  Parses string with Unix pathname. Returns table.

  {
    Directory -- [s] Parent directory path ending with '/'
    Name -- [s] Name of leaf file or directory
    IsDirectory -- [b] True if leaf is directory
    IsAbsolute -- [b] True if Directory is absolute path
    Path -- [t] List of directory names ending with leaf name
  }

  Note:

    ".." element

    It does not interpret "a/b/.." as "a/" because "b" may be
    a symlink to another directory.

    "IsDirectory" field may be false negative

    We are using just provided string and can't check whether "a"
    is directory or file. But for "a/" we know it's directory.

  Examples:

    /a
      Directory = '/'
      Name = 'a'
      IsAbsolute = true
      IsDirectory = false
      Path = {'a'}
    a/
      Directory = ''
      Name = 'a'
      IsAbsolute = false
      IsDirectory = true
      Path = {'a'}
    ././//a/./
      Same as for "a/"
    a/b/..
      Directory = 'a/b/'
      Name = '..'
      IsDirectory = true
      IsAbsolute = false
      Path = {'a', 'b', '..'}
    /
      Directory = '/'
      Name = ''
      IsDirectory = true
      IsAbsolute = true
      Path = {}
]]
local parse_pathname =
  function(path_name)
    assert_string(path_name)

    path_name = cleanup_pathname(path_name)

    local is_absolute = starts_with(path_name, '/')

    local is_directory =
      ends_with(path_name, '/') or
      ends_with(path_name, '..')

    if not ends_with(path_name, '/') then
      -- Adjust for split_string()
      path_name = path_name .. '/'
    end

    local path = split_string(path_name, '/')

    if is_absolute then
      -- For absolute paths like "/a" first entry in <path> is ""
      table.remove(path, 1)
    end

    local leaf_name = path[#path] or ''

    local parent_dir_name = table.concat(path, '/', 1, #path - 1)

    if (parent_dir_name ~= '') or is_absolute then
      parent_dir_name = parent_dir_name .. '/'
    end

    local Result =
      {
        Directory = parent_dir_name,
        Name = leaf_name,
        Path = path,
        IsAbsolute = is_absolute,
        IsDirectory = is_directory,
      }

    return Result
  end

-- Export:
return parse_pathname

--[[
  2016-09
  2018-06
  2026-04-22
  2026-04-23
]]
