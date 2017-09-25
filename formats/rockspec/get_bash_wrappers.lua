local fill_template = request('fill_template')
local bash_wrapper_template = request('bash_wrapper_template')

return
  function(cfg)
    assert_table(cfg.bash_commands)
    local result = {}
    for i, rec in ipairs(cfg.bash_commands) do
      result[i] =
        fill_template(
          bash_wrapper_template,
          {
            package = cfg.project_name,
            lua_main = rec.lua_module,
          }
        )
    end
    return result
  end
