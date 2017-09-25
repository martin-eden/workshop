local fill_template = request('fill_template')
local bash_wrapper_template = request('bash_wrapper_template')

return
  function(cfg)
    local result =
      fill_template(
        bash_wrapper_template,
        {
          package = cfg.project_name,
          lua_main = cfg.lua_main_module,
        }
      )
    return result
  end
