-- Character classifier interface/config

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

--[[
  Interface

    [f] is_delimiter
    [f] is_comment
    [f] is_newline
]]

-- Imports:
local Syntels = request('^.^.Syntels')

local space = Syntels.space
local tab = Syntels.tab
local newline = Syntels.newline
local carriage_return = Syntels.carriage_return
local comment_char = Syntels.comment_char

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
