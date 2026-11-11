-- Return shell script that implements planned actions

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

--[[
  Generates shell script that

    * deletes directories in given list
    * copies files with directories creation
]]

local compare_copyrecs
do
  -- Compare pathnames by name depth and name
  local compare_pathnames
  do
    local parse_pathname =
      request('!.concepts.path_name.pathname_from_str')
    compare_pathnames =
      function(path_a_str, path_b_str)
        local path_a = parse_pathname(path_a_str)
        local path_b = parse_pathname(path_b_str)

        local depth_a = #path_a
        local depth_b = #path_b

        if (depth_a == depth_b) then
          return (path_a_str < path_b_str)
        end

        return (depth_a < depth_b)
      end
  end
  compare_copyrecs =
    function(rec_a, rec_b)
      return compare_pathnames(rec_a[2], rec_b[2])
    end
end

-- For "a/b/c/" mark as created "a/", "a/b/" and "a/b/c".
local mark_created_dirs
do
  local parse_pathname =
    request('!.concepts.path_name.pathname_from_str')
  local compile_pathname =
    request('!.concepts.path_name.pathname_to_str')
  mark_created_dirs =
    function(pathname, dirs_created)
      local parsed_pathname = parse_pathname(pathname)
      for idx, dir_name in ipairs(parsed_pathname) do
        local part_dir_name = compile_pathname(parsed_pathname, 1, idx)
        dirs_created[part_dir_name] = true
      end
    end
end

local add_to_list = request('!.concepts.list.add_item')
local tbl_sort = table.sort
local get_cmd_rmdir = request('!.mechs.cmdline.get_cmd_rmdir')
local get_host_dir = request('!.concepts.path_name.get_host_dir_str')
local get_cmd_mkdir = request('!.mechs.cmdline.get_cmd_mkdir')
local get_cmd_copyfile = request('!.mechs.cmdline.get_cmd_file_copy')
local lines_to_str = request('!.convert.lines_to_str')

-- Export:
return
  function(me)
    local lines = { }

    local add_line =
      function(line_str)
        add_to_list(lines, line_str)
      end

    -- Add shebang:
    add_line('#!/bin/sh')

    -- ( Commands to delete directories
    if (#me[1] > 0) then
      add_line('')
    end
    tbl_sort(me[1])
    for _, pathname in ipairs(me[1]) do
      add_line(get_cmd_rmdir(pathname):to_string())
    end
    -- )

    -- ( Commands to copy files and create directories
    local dirs_created = { }

    tbl_sort(me[2], compare_copyrecs)

    local prev_dest_dir = ''

    for _, copyrec in ipairs(me[2]) do
      local src_name = copyrec[1]
      local dest_name = copyrec[2]

      local dest_dir = get_host_dir(dest_name)

      if (dest_dir ~= prev_dest_dir) then
        add_line('')
        prev_dest_dir = dest_dir
      end

      if not dirs_created[dest_dir] then
        add_line(get_cmd_mkdir(dest_dir):to_string())
        mark_created_dirs(dest_dir, dirs_created)
      end

      add_line(get_cmd_copyfile(src_name, dest_name):to_string())
    end
    -- )

    return lines_to_str(lines)
  end

--[[
  2018 #
  2019 #
  2026 # # #
  2026-11-11
]]
