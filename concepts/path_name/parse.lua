--[[
  Parse string with Unix pathname. Return table.

  {
    path: table - sequence of strings
    directory: string
    name: string or nil
    is_directory: bool
    is_absolute: bool
  }

  ".." element: It does not interpret "a/b/.." as "a/" because
  "b" may be a symlink to another directory.

  "is_directory" field may be false negative.

  Examples:

    /a
      path = {'a'}
      directory = '/'
      name = 'a'
      is_directory = false
      is_absolute = true
    ././//a/./
      path = {'a'}
      directory = 'a/'
      name = 'a'
      is_directory = true
      is_absolute = false
    a/b/..
      path = {'a', 'b', '..'}
      directory = 'a/b/../'
      name = '..'
      is_directory = true
      is_absolute = false
    /
      path = {}
      directory = '/'
      is_directory = true
      is_absolute = true
]]

local split_string = request('!.string.split')

return
  function(path_name)
    assert_string(path_name)

    local result =
      {
        path = nil,
        directory = nil,
        name = nil,
        is_directory = false,
        is_absolute = false,
      }

    -- If starts with "/" than path is absolute.
    if (path_name:sub(1, 1) == '/') then
      result.is_absolute = true
    end

    -- Replace "//" with "/".
    path_name = path_name:gsub('//+', '/')

    -- Replace "/./" with "/".
    local num_repl
    repeat
      path_name, num_repl = path_name:gsub('/%./', '/')
    until (num_repl == 0)

    -- Strip "./" from start.
    path_name = path_name:gsub('^%./', '')

    -- Replace in tail "/." to "/".
    if (path_name:sub(-2) == '/.') then
      path_name = path_name:gsub('/%.$', '/')
    end

    -- Directory ends on "/" or on "..".
    if
      (path_name:sub(-1) == '/') or
      (path_name:sub(-2) == '..')
    then
      result.is_directory = true
    end

    result.path = split_string(path_name, '/')
    result.name = result.path[#result.path]

    if result.is_directory then
      result.directory = table.concat(result.path, '/')
    else
      result.directory = table.concat(result.path, '/', 1, #result.path - 1)
    end

    if
      (result.directory ~= '') or
      result.is_absolute
    then
      result.directory = result.directory .. '/'
    end

    return result
  end
