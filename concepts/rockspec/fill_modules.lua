local get_file_name = request('get_file_name')
local get_module_name = request('get_module_name')

return
  function(cfg)
    local result = {}
    for _, file_name in ipairs(cfg.used_files) do
      local cut_file_name = get_file_name(file_name)
      local module_name = get_module_name(cfg, cut_file_name)
      result[module_name] = cut_file_name
    end
    return result
  end
