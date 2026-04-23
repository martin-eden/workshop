-- Parse pathname string to categorized table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

--[[
  Pathnames in Unix can be obscure: ".///.//a/.//" is same as "a/"

  Here is function to parse them.

  Also it provides list of node names in path.

  And flags that
    * path is absolute
    * ends on directory

  Result structure

    {
      Directory -- [s] Parent directory path ending with '/'
      Name -- [s] Name of leaf file or directory
      IsDirectory -- [b] True if leaf is directory
      IsAbsolute -- [b] True if Directory is absolute path
      Path -- [t] List of directory names ending with leaf name
      FullName -- [s] Directory + Name. Ends with '/' if leaf is directory
    }
]]

--[[
  Contract

  * .Directory always ends with "/"
  * .Name never contains "/"
]]

--[[
  Using structure

  * Canonical path == .Directory + .Name

  * Using .Path

    if .IsAbsolute
      ChDir "/"

    if not .IsDirectory
      RemoveLastEntry .Path

    for each NodeName in .Path
      ChDir NodeName
]]

-- Imports:
local starts_with = request('!.string.starts_with')
local ends_with = request('!.string.ends_with')
local split_string = request('!.string.split')

local normalize_pathname =
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

    -- If it's relative path and not starts with ".." ..
    if
      not starts_with(path_name, '/') and
      not starts_with(path_name, '..')
    then
      -- .. add relative prefix
      path_name = './' .. path_name
    end

    -- If it ends as directory ..
    if ends_with(path_name, '/') then
      -- .. add self name postfix
      path_name = path_name .. '.'
    end

    --[[
      Custom case for ".." which is intact till here.
      We need at least one slash in returned string.
    ]]
    if (path_name == '..') then
      path_name = '../.'
    end

    assert(path_name ~= '')

    return path_name
  end

local get_path =
  function(path_name)
    if not ends_with(path_name, '/') then
      -- Adjust for split_string()
      path_name = path_name .. '/'
    end

    local path = split_string(path_name, '/')

    assert(#path >= 2)

    return path
  end

local get_parent_dir_name =
  function(path)
    return table.concat(path, '/', 1, #path - 1) .. '/'
  end

--[[
  Parses string with Unix pathname. Returns table
]]
local parse_pathname =
  function(path_name)
    assert_string(path_name)

    path_name = normalize_pathname(path_name)

    local path = get_path(path_name)

    local leaf_name = path[#path]

    local parent_dir_name = get_parent_dir_name(path)

    --[[
      For absolute paths like "/a" first entry in <path> is "".
      Relative paths may be prefixed with "./" or with "../".
      So first entry is "." or "..".

      We don't want first entry as "" or "." in export.
    ]]
    local first_item = path[1]
    if
      (first_item == '') or
      (first_item == '.')
    then
      table.remove(path, 1)
    end

    local is_absolute =
      starts_with(path_name, '/')

    local is_directory =
      ends_with(path_name, '/') or
      ends_with(path_name, '/.') or
      ends_with(path_name, '/..')

    local full_name
    full_name = parent_dir_name .. leaf_name
    if is_directory then
      full_name = full_name .. '/'
    end

    local Result =
      {
        Directory = parent_dir_name,
        Name = leaf_name,
        Path = path,
        IsAbsolute = is_absolute,
        IsDirectory = is_directory,
        FullName = full_name,
      }

    return Result
  end

-- Export:
return parse_pathname

--[[
  Notes

    * Empty string as pathname is illegal in POSIX

      We treat it as ".".

    * "./" prefix

      We are adding "./" prefix to directory name for relative paths.
      (Absolute paths have "/" as is.)

      This is handy for outer code. It can rely that .Directory always
      ends with "/".

    * ".." element

      It does not interpret "a/b/.." as "a/" because "b" may be
      symlink to another directory.

    * "IsDirectory" field may be false negative

      We are using just provided string and can't check whether "a"
      is directory or file. But for "a/" we know it's directory.

    * String processing

      I don't like string preprocessing with gsub()

      I would like to return here one day and implement proper
      parsing based on list of chunks separated by "/".

    * Alternative contract

      * Directory name always ends with "/"

        Makes sense when .Name is a directory.

        So you can always catenate it without adding slash.

        But so there will be no "." and ".." which are proper
        POSIX names too. There will be "./" and "../". A bit ugly.

  Examples

    ""
      Directory = './'
      Name = '.'
      Path = {'.'}
      IsAbsolute = false
      IsDirectory = true

    /
      Directory = '/'
      Name = '.'
      Path = {'.'}
      IsAbsolute = true
      IsDirectory = true

    a/b/c
      Directory = './a/b/'
      Name = 'c'
      Path = {'a', 'b', 'c'}
      IsAbsolute = false
      IsDirectory = false

    a/
      Directory = './a/'
      Name = '.'
      Path = {'a', '.'}
      IsAbsolute = false
      IsDirectory = true

    ././//a/./
      Same as for "a/"

    a/../b
      Directory = './a/../'
      Name = 'b'
      Path = {'a', '..', 'b'}
      IsDirectory = false
      IsAbsolute = false
]]

--[[
  2016-09
  2018-06
  2026-04-22
  2026-04-23
]]
