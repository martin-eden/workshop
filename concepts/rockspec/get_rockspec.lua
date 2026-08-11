-- Return string with .rockspec file contents

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

-- Imports:
local fill_modules = request('fill_modules')
local get_modules_text = request('get_modules_text')
local get_wrappers_text = request('get_wrappers_text')
local rockspec_template = request('rockspec_template')
local fill_template = request('fill_template')
local quote = request('!.string.quote')

local get_rockspec =
  function(Config)
    local Modules = fill_modules(Config)

    local Wrappers = { }
    if Config.commands then
      for _, Rec in ipairs(Config.commands) do
        Wrappers[Rec.command] = Rec.wrapper
      end
    end

    local Substitutions =
      {
        package = quote(Config.project_name),
        repository_url = quote(Config.repository.url),
        repository_branch = quote(Config.repository.branch),
        short_desc = quote(Config.short_desc),
        description = quote(Config.description),
        license = quote(Config.license),
        wrappers = get_wrappers_text(Wrappers),
        modules = get_modules_text(Modules),
      }

    local result = fill_template(rockspec_template, Substitutions)

    return result
  end

-- Export:
return get_rockspec

--[[
  2017 # # # #
]]
