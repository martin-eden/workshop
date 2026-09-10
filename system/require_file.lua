-- Load file contents as string. Searches in Lua modules directories

--[[
  Author: Martin Eden
  Last mod.: 2026-09-10
]]

--[[
  File name is customized module name

    We are using "/" as directory separator (not ".")

    "!/" at start means path is relative to "workshop"'s directory

    We are using ".." for upper directory (not "^")
]]

local split_string = request('!.string.split')
local pathname_from_str = request('!.concepts.path_name.pathname_from_str')
local pathname_to_str = request('!.concepts.path_name.pathname_to_str')
local get_host_dir = request('!.concepts.path_name.get_host_dir_str')
local file_exists = request('!.file_system.file.exists')
local map_table_values = request('!.table.map_values')
local get_table_keys = request('!.table.get_keys')
local add_to_list = request('!.concepts.list.add_item')
local file_to_str = request('!.convert.file_to_str')

local package_capture_char
local package_items_sep
do
  local PackageConfig = request('get_package_config')()

  package_capture_char = PackageConfig.capture_char
  package_items_sep = PackageConfig.items_sep
end

local str_find = string.find

local get_base_dir =
  function(luas_require_dir)
    local host_dir = luas_require_dir

    repeat
      host_dir = get_host_dir(host_dir)
    until not str_find(host_dir, package_capture_char)

    return host_dir
  end

local remove_duplicates_from_list =
  function(List)
    return get_table_keys(map_table_values(List))
  end

local str_starts_with = request('!.string.starts_with')
local str_sub = string.sub
local str_gsub = string.gsub
local str_format = string.format

-- Export:
return
  function(file_module_name)
    --[[
      We would like to use request()'s facilities for relative
      paths but they are written for Lua modules and not exposed.
    ]]

    assert_string(file_module_name)

    local is_absolute_name = str_starts_with(file_module_name, '!/')
    if is_absolute_name then
      file_module_name = str_sub(file_module_name, 3)
    end

    local workshop_dir
    workshop_dir = get_base_prefix()
    workshop_dir = str_gsub(workshop_dir, '%.', '/')

    local SearchPathsList =
      split_string(_G.package.path, package_items_sep)

    local PathnamesToTry = { }

    for idx, path in ipairs(SearchPathsList) do
      local pathname_prefix = get_base_dir(path)
      if is_absolute_name then
        pathname_prefix = pathname_prefix .. workshop_dir
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
      str_format("Failed to locate module file %q.", file_module_name)
    )
  end

--[[
  2026-05-08
  2026-09-10
]]
