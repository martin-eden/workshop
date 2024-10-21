-- Return shell command to change current directory. GNU/Bash.

-- Last mod.: 2024-10-21

local CommandFmt = 'cd %q'

return
  function(Path)
    assert_string(Path)
    local Command = string.format(CommandFmt, Path)
    return Command
  end

--[[
  2024-02-19
  2024-10-21
]]
