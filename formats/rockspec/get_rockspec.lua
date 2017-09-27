local fill_modules = request('fill_modules')
local get_modules_text = request('get_modules_text')
local get_wrappers_text = request('get_wrappers_text')
local rockspec_template = request('rockspec_template')
local fill_template = request('fill_template')
local quote = request('!.string.quote')

return
  function(cfg)
    local modules = fill_modules(cfg)
    local wrappers
    if cfg.commands then
      wrappers = {}
      for _, rec in ipairs(cfg.commands) do
        wrappers[rec.command] = rec.wrapper
      end
    end
    local substitutions =
      {
        package = quote(cfg.project_name),
        repository_url = quote(cfg.repository.url),
        repository_branch = quote(cfg.repository.branch),
        short_desc = quote(cfg.short_desc),
        description = quote(cfg.description),
        license = quote(cfg.license),
        wrappers = get_wrappers_text(wrappers),
        modules = get_modules_text(modules),
      }
    local result = fill_template(rockspec_template, substitutions)
    return result
  end

