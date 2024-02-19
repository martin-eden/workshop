-- Return shell command to change current directory. GNU/Bash.

-- Last mod.: 2024-02-19

local CommandFmt = 'cd "%s"'
return
  function(Path)
    assert_string(Path)
    local Command = string.format(CommandFmt, Path)
    return Command
  end
