-- Character classifier interface/config

--[[
  Author: Martin Eden
  Last mod.: 2026-09-26
]]

--[[
  Interface

    [f] is_delimiter
    [f] is_comment
    [f] is_newline
]]

local space
local tab
local newline
local carriage_return
local comment_char
do
  local Syntels = request('^.^.Syntels')
  space = Syntels.space
  tab = Syntels.tab
  newline = Syntels.newline
  carriage_return = Syntels.carriage_return
  comment_char = Syntels.comment_char
end

local is_space =
  function(char)
    return (char == space) or (char == tab)
  end

local is_newline =
  function(char)
    return (char == newline) or (char == carriage_return)
  end

local is_comment =
  function(char)
    return (char == comment_char)
  end

local is_delimiter =
  function(char)
    return is_space(char) or is_newline(char) or is_comment(char)
  end

-- Export:
return
  {
    is_delimiter = is_delimiter,
    is_comment = is_comment,
    is_newline = is_newline,
  }

--[[
  2025-03-28
  2026-05-31
]]
