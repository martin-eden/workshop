-- Load file contents as string. Searches in Lua modules directories

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

--[[
  File name is customized module name

    We are using "/" as directory separator (not ".")

    "!/" at start means path is relative to "workshop"'s directory

    You can use ".." for upper directory (not "^")
]]

-- Imports:
local get_package_config = request('!.concepts.lua.get_package_config')
local split_string = request('!.string.split')
local parse_path = request('!.concepts.path_name.parse')
local file_exists = request('!.file_system.file.exists')
local map_table_values = request('!.table.map_values')
local get_table_keys = request('!.table.get_keys')
local add_to_list = request('!.concepts.list.add_item')
local file_to_str = request('!.convert.file_to_str')

local package_config = get_package_config()

local get_host_dir =
  function(luas_require_dir)
    local host_dir = luas_require_dir

    repeat
      host_dir = parse_path(host_dir).HostDir
    until not string.find(host_dir, package_config.CaptureChar)

    return host_dir
  end

local remove_duplicates_from_list =
  function(List)
    return get_table_keys(map_table_values(List))
  end

local require_file =
  function(file_module_name)
    --[[
      We would like to use request()'s facilities for relative
      paths but they are written for Lua modules and not exposed.
    ]]

    assert_string(file_module_name)

    local is_absolute_name =
      (string.sub(file_module_name, 1, 2) == '!/')

    if is_absolute_name then
      file_module_name = string.sub(file_module_name, 3)
    end

    local workshops_dir
    workshops_dir = get_base_prefix()
    workshops_dir = string.gsub(workshops_dir, '%.', '/')

    local SearchPathsList =
      split_string(_G.package.path, package_config.ItemsSep)

    local PathnamesToTry = { }

    for idx, path in ipairs(SearchPathsList) do
      local pathname_prefix = get_host_dir(path)
      if is_absolute_name then
        pathname_prefix = pathname_prefix .. workshops_dir
      end
      local pathname_to_try = pathname_prefix .. file_module_name
      add_to_list(PathnamesToTry, pathname_to_try)
    end

    PathnamesToTry = remove_duplicates_from_list(PathnamesToTry)

    for idx, pathname_to_try in ipairs(PathnamesToTry) do
      if file_exists(pathname_to_try) then
        return file_to_str(pathname_to_try)
      end
    end

    error(
      string.format(
        "Failed to locate module file %q.",
        file_module_name
      )
    )
  end

-- Export:
return require_file

--[[
  2026-05-08
]]
