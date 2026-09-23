-- Return list of documentation files for given list of ".lua" files

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

--[[
  Input

    [t] FilesList -- Strings list. Each entry is pathname.

  Output

    [t] -- documentation files pathnames list

      Each entry is pathname to documentation file.
      We guarantee there will be no duplicate entries.
      Only files that really exists are included.
]]

local pathname_from_str = request('!.concepts.path_name.pathname_from_str')
local get_host_dir = request('!.concepts.path_name.get_host_dir_str')
local get_files_list = request('!.file_system.directory.get_files_list')
local add_to_list = request('!.concepts.list.add_item')

local is_documentation_name
do
  local DocNameEndings = { '.txt', '.md', '.is' }
  local ends_with = request('!.string.ends_with')

  is_documentation_name =
    function(filename)
      for _, doc_ending in ipairs(DocNameEndings) do
        if ends_with(filename, doc_ending) then
          return true
        end
      end
      return false
    end
end

-- Export:
return
  function(FilesList)
    local Result = { }

    local ProcessedDirectories_Map = { }

    for _, module_pathname in ipairs(FilesList) do
      if ProcessedDirectories_Map[module_dirname] then goto next end

      local module_dirname = get_host_dir(module_pathname)
      local Files = get_files_list(module_dirname)

      for _, filename in ipairs(Files) do
        if is_documentation_name(filename) then
          add_to_list(Result, module_dirname .. filename)
        end
      end

      ProcessedDirectories_Map[module_dirname] = true

      ::next::
    end

    return Result
  end

--[[
  2018 #
  2024 # #
  2026 # #
  2026-09-23
]]
