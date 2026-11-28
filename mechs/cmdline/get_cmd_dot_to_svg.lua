-- Shell command to layout graph in .dot file to .svg

--[[
  Author: Martin Eden
  Last mod.: 2026-11-28
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(dot_pathname, svg_pathname)
    local command =
      {
        'dot',
        '-Tsvg',
        normalize(dot_pathname),
        '-o',
        normalize(svg_pathname),
      }

    return shell_command.create(command)
  end

--[[
  2026 #
]]
