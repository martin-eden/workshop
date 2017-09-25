local strip_self_prefix = request('strip_self_prefix')
local strip_updirs = request('strip_updirs')
local strip_lua_postfix = request('strip_lua_postfix')

return
  function(cfg, file_name)
    local result

    result = file_name
    result = strip_self_prefix(result)
    result = strip_updirs(result)
    result = strip_lua_postfix(result)
    result = result:gsub('/', '.')
    result = cfg.project_name .. '.' .. result

    return result
  end
