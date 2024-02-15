-- Split string to table with sequence of lines

--[[
  Version: 1
  Last mod.: 2024-02-15
]]

--[[
  Typical usage scenario is load not very large file into memory
  as string, then split string to lines.

  That's very typical task and I want simple code to do this.

  Lua offers string-wise reading from files io.lines() and I have
  similar iterator string.lines(). I'm sick with iterators in Lua.
  Cool stuff (like meta-tables and coroutines), Roberto, but not
  practical for me.
]]

local SplitLine = request('!.string.split')

return
  function(S)
    local Delimiter = '\n'
    return SplitLine(S, Delimiter)
  end
