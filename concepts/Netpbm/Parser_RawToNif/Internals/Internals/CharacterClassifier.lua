-- Character classifier interface/config

--[[
  Author: Martin Eden
  Last mod.: 2025-05-31
]]

--[[
  Interface

    [f] is_delimiter
    [f] is_comment
    [f] is_newline
]]

local is_space =
  function(char)
    return (char == ' ') or (char == '\t')
  end

local is_newline =
  function(char)
    return (char == '\n') or (char == '\r')
  end

local is_comment =
  function(char)
    return (char == '#')
  end

local is_delimiter =
  function(char)
    return is_space(char) or is_newline(char) or is_comment(char)
  end

local Interface =
  {
    is_delimiter = is_delimiter,
    is_comment = is_comment,
    is_newline = is_newline,
  }

-- Export:
return Interface

--[[
  2025-03-28
  2026-05-31
]]
