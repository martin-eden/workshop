-- Return list of documentation files given list of file pathnames

--[[
  Author: Martin Eden
  Last mod.: 2026-11-10
]]

--[[
  Input

    [t] -- pathnames string list

  Output

    [t] -- doc files pathnames list
      i [s] -- pathname to doc file
]]

local get_host_dir = request('!.concepts.path_name.get_host_dir_str')
local get_files_list = request('!.file_system.directory.get_files_list')
local is_doc
do
  local is_doc_extension
  do
    local doc_extensions = { 'txt', 'md' }
    local map_values = request('!.table.map_values')
    is_doc_extension = map_values(doc_extensions)
  end
  local get_extension = request('!.concepts.path_name.get_extension')
  is_doc =
    function(pathname)
      return is_doc_extension[get_extension(pathname)]
    end
end
local add_to_list = request('!.concepts.list.add_item')

-- Export:
return
  function(files)
    local result = { }

    local dirs = { }
    for _, pathname in ipairs(files) do
      dirs[get_host_dir(pathname)] = true
    end

    for dirname in pairs(dirs) do
      local dir_files = get_files_list(dirname)
      for _, filename in ipairs(dir_files) do
        if is_doc(filename) then
          add_to_list(result, dirname .. filename)
        end
      end
    end

    return result
  end

--[[
  2018 #
  2024 # #
  2026 # # # #
  2026-11-10
]]
