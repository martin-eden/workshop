-- Shell command to layout graph in .dot file to .svg

--[[
  Author: Martin Eden
  Last mod.: 2026-09-08
]]

local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

-- Export:
return
  function(dot_pathname, svg_pathname)
    local Command =
      {
        'dot',
        {
          '-Tsvg',
          normalize(dot_pathname),
          '-o',
          normalize(svg_pathname),
        },
      }

    return ShellCommand.create(Command)
  end

--[[
  2026-09-08
]]
