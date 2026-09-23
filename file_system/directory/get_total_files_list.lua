-- Return list of file names in given directory and subdirectories

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local normalize = request('!.concepts.path_name.normalize')

local retrieve
do
  local get_files = request('get_files_list')
  local get_dirs = request('get_directories_list')
  local add_separator = request('!.concepts.path_name.add_separator')
  local add_to_list = request('!.concepts.list.add_item')

  retrieve =
    function(base_dir, Result)
      base_dir = add_separator(base_dir)

      local Files = get_files(base_dir)
      for _, file_name in ipairs(Files) do
        add_to_list(Result, normalize(base_dir .. file_name))
      end

      local Dirs = get_dirs(base_dir)
      for _, dir_name in ipairs(Dirs) do
        retrieve(normalize(base_dir .. dir_name), Result)
      end
    end
end

return
  function(base_dir)
    local Result = { }
    retrieve(normalize(base_dir), Result)
    return Result
  end

--[[
  2026-09-23
]]
