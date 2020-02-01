--[[
  Generate Bash script that copies all planned files with directories
  creation.

  - tbl -- -> str
   (self)

  * Deepest directories created first. This is to reduce number of
    "mkdir" commands: "mkdir -p a/b/" is better than "mkdir -p a/;
    mkdir -p a/b/". To reach this goal we sort files list.
]]

local get_cmd_mkdir = request('!.mechs.cmdline.get_cmd_mkdir')
local get_cmd_copy = request('!.mechs.cmdline.get_cmd_copy')
local get_cmd_rmdir = request('!.mechs.cmdline.get_cmd_rmdir')
local parse_pathname = request('!.formats.path_name.parse')

local compare =
  function(rec_a, rec_b)
    local a, b = rec_a.src_name, rec_b.src_name
    local deep_a = #parse_pathname(a).path
    local deep_b = #parse_pathname(b).path
    if (deep_a > deep_b) then
      return true
    elseif (deep_a == deep_b) then
      return (a < b)
    else
      return false
    end
  end

return
  function(self)
    local result

    local directories_created = {}

    local mark_directory_created =
      function(dir_name)
        local parent_path = ''
        for parent_dir in dir_name:gmatch('(.-)/') do
          parent_path = parent_path .. parent_dir
          parent_path = parent_path .. '/'
          directories_created[parent_path] = true
        end
        directories_created[dir_name] = true
      end

    result =
      {
        '#! /bin/bash',
        '',
      }

    if next(self.dirs_to_delete) then
      table.sort(self.dirs_to_delete)
      for i, dir_name in ipairs(self.dirs_to_delete) do
        table.insert(result, get_cmd_rmdir(dir_name))
      end
    end

    table.sort(self.files_to_copy, compare)
    for i, rec in ipairs(self.files_to_copy) do
      local from = rec.src_name
      local to = rec.dest_name
      local directory = parse_pathname(to).directory
      if not directories_created[directory] then
        table.insert(result, '')
        table.insert(result, get_cmd_mkdir(directory))
        mark_directory_created(directory)
      end
      table.insert(result, get_cmd_copy(from, to))
    end

    result = table.concat(result, '\n') .. '\n'

    return result
  end
