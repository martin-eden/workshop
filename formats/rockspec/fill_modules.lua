local get_file_name = request('get_file_name')
local get_module_name = request('get_module_name')

return
  function(cfg)
    local result = {}
    local files = cfg.used_files
    table.sort(files)
    for i = 1, #files do
      local file_name = get_file_name(files[i])
      local module_name = get_module_name(cfg, file_name)
      result[module_name] = file_name
    end
    return result
  end
