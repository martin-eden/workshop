-- Return bash script that copies files with directories creation

--[[
  Author: Martin Eden
  Last mod.: 2026-05-11
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')
local split_string = request('!.string.split')
local parse_pathname = request('!.concepts.path_name.parse')
local get_cmd_rmdir = request('!.mechs.cmdline.get_cmd_rmdir')
local get_cmd_mkdir = request('!.mechs.cmdline.get_cmd_mkdir')
local get_cmd_copyfile = request('!.mechs.cmdline.get_cmd_copy')
local lines_to_str = request('!.convert.lines_to_str')

--[[
  Compare pathnames by name depth and name
]]
local compare_pathnames =
  function(path_a_str, path_b_str)
    local Path_A = split_string(path_a_str, '/')
    local Path_B = split_string(path_b_str, '/')

    local depth_a = #Path_A
    local depth_b = #Path_B

    if (depth_a == depth_b) then
      return (path_a_str < path_b_str)
    end

    return (depth_a < depth_b)
  end

local compare_copyrecs =
  function(Rec_A, Rec_B)
    return compare_pathnames(Rec_A.src_name, Rec_B.src_name)
  end

--[[
  For "a/b/c/" mark as created "a/", "a/b/" and "a/b/c".
]]
local mark_directories_created =
  function(pathname, DirectoriesCreated_Map)
    local parent_pathname = ''

    for dir_name in pathname:gmatch('(.-)/') do
      parent_pathname = parent_pathname .. dir_name .. '/'

      DirectoriesCreated_Map[parent_pathname] = true
    end

    DirectoriesCreated_Map[pathname] = true
  end

--[[
  Generate Bash script that

    * deletes directories in given list
    * copies files with directories creation
]]
local GetScript =
  function(Me)
    local Lines = { }

    local add_line =
      function(line_str)
        add_to_list(Lines, line_str)
      end

    -- Add shebang:
    add_line('#!/bin/bash')

    -- ( Commands to delete directories
    if (#Me.DirsToDelete > 0) then
      add_line('')
    end

    table.sort(Me.DirsToDelete)

    for _, pathname in ipairs(Me.DirsToDelete) do
      add_line(get_cmd_rmdir(pathname))
    end
    -- )

    -- ( Commands to copy files and create directories
    local DirectoriesCreated_Map = { }

    table.sort(Me.FilesToCopy, compare_copyrecs)

    local prev_dest_dir = ''

    for _, CopyRec in ipairs(Me.FilesToCopy) do
      local src_name = CopyRec.src_name
      local dest_name = CopyRec.dest_name

      local dest_dir = parse_pathname(dest_name).HostDir

      if (dest_dir ~= prev_dest_dir) then
        add_line('')

        prev_dest_dir = dest_dir
      end

      if not DirectoriesCreated_Map[dest_dir] then
        add_line(get_cmd_mkdir(dest_dir))

        mark_directories_created(dest_dir, DirectoriesCreated_Map)
      end

      add_line(get_cmd_copyfile(src_name, dest_name))
    end
    -- )

    return lines_to_str(Lines)
  end

-- Export:
return GetScript

--[[
  2018
  2019
  2026-04-17
  2026-05-11
  2026-05-28
]]
