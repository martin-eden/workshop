local fill_modules = request('fill_modules')
local get_modules_text = request('get_modules_text')
local get_shell_scripts_text = request('get_shell_scripts_text')
local rockspec_template = request('rockspec_template')
local fill_template = request('fill_template')

return
  function(cfg)
    local modules = fill_modules(cfg)
    local shell_scripts
    if cfg.bash_script_name then
      shell_scripts =
        {
          [cfg.bash_command_name] = cfg.bash_script_name
        }
    end
    local substitutions =
      {
        package = cfg.project_name,
        modules = get_modules_text(modules),
        shell_scripts = get_shell_scripts_text(shell_scripts),
      }
    local result = fill_template(rockspec_template, substitutions)
    return result
  end

