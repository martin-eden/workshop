local fill_template = request('fill_template')
local wrapper_template = request('wrapper_template')

return
  function(cfg)
    assert_table(cfg.commands)
    local result = {}
    for i, rec in ipairs(cfg.commands) do
      result[i] =
        fill_template(
          wrapper_template,
          {
            package = cfg.project_name,
            lua_main = rec.lua_script,
          }
        )
    end
    return result
  end
