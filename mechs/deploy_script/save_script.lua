local get_script = request('get_script')

local save_script =
  function(modules, script_name, deploy_dir)
    script_name = script_name or 'deploy.sh'
    local f, err_msg = io.open(script_name, 'w+')
    if not f then
      error(err_msg)
    end
    f:write('#!/bin/bash', '\n')
    f:write(get_script(modules, deploy_dir))
    f:close()
  end

return save_script
