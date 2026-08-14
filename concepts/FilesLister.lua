-- Files/directories lister

--[[
  Author: Martin Eden
  Last mod.: 2026-08-14
]]

--[[
  Files lister

  It has concept of Base Directory and methods to list file names and
  directory names under that directory.
]]

--[[
  Data storage format

    [s] base directory
]]

local get_base_directory = function(Me) return Me[1] end

local set_base_directory
do
  local add_separator = request('!.concepts.path_name.add_separator')
  local normalize_name = request('!.concepts.path_name.normalize')

  set_base_directory =
    function(Me, base_dir)
      assert_string(base_dir)

      Me[1] = normalize_name(add_separator(base_dir))
    end
end

-- Return file names in base directory as list of strings
local get_files
-- Return directory names in base directory as list of strings
local get_directories
do
  local get_clean_pathnames
  do
    local empty = ''
    local remove_prefix = request('!.string.remove_prefix')
    local add_to_list = request('!.concepts.list.add_item')
    get_clean_pathnames =
      function(PathNames, base_dir)
        local Result = { }

        for idx, file_name in ipairs(PathNames) do
          local cleaned_file_name = remove_prefix(file_name, base_dir)
          if (cleaned_file_name ~= empty) then
            add_to_list(Result, cleaned_file_name)
          end
        end

        return Result
      end
  end
  do
    local get_files_list = request('!.file_system.directory.get_files_list')
    get_files =
      function(Me)
        local base_dir = Me:GetBaseDirectory()

        local FileNames = get_files_list(base_dir)
        FileNames = get_clean_pathnames(FileNames, base_dir)

        return FileNames
      end
  end
  do
    local get_dirs_list = request('!.file_system.directory.get_directories_list')
    get_directories =
      function(Me)
        local base_dir = Me:GetBaseDirectory()

        local Dirs = get_dirs_list(base_dir)
        Dirs = get_clean_pathnames(Dirs, base_dir)

        return Dirs
      end
  end
end

local Interface

local create
do
  local DefaultCore
  do
    local self_dir
    do
      local PathEls = request('!.concepts.path_name.Syntels')
      self_dir = PathEls.self_dir
    end
    DefaultCore = { self_dir }
  end
  local create_instance = request('!.table.create_instance')
  create =
    function()
      return create_instance(DefaultCore, Interface)
    end
end

Interface =
  {
    create = create,

    -- Config
    SetBaseDirectory = set_base_directory,
    GetBaseDirectory = get_base_directory,

    -- Run
    GetFiles = get_files,
    GetDirectories = get_directories,
  }

-- Export:
return Interface

--[[
  2017
  2026 #
  2026-08-14
]]
