-- NetP?M tokens writer

--[[
  Author: Martin Eden
  Last mod.: 2026-09-27
]]

--[[
  Storage format

    1 [t] -- output stream
    2 [b] -- need for separator
]]

local Syntels = request('^.Syntels')
local space_char = Syntels.space
local newline_char = Syntels.newline
local comment_char = Syntels.comment_char

local space =
  function(Me)
    Me[1]:Write(space_char)
    Me[2] = false
  end

local newline =
  function(Me)
    Me[1]:Write(newline_char)
    Me[2] = false
  end

local data =
  function(Me, data_str)
    if Me[2] then
      space(Me)
    end

    Me[1]:Write(data_str)
    Me[2] = true
  end

local comment =
  function(Me, comment_str)
    if Me[2] then
      space(Me)
      space(Me)
    end
    data(Me, comment_char)
    data(Me, comment_str)
    newline(Me)
  end

local Interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(Output)
      local Me = { Output, false }
      attach_methods(Me, Interface)

      return Me
    end
end

Interface =
  {
    create = create,
    Data = data,
    Comment = comment,
    Space = space,
    Newline = newline,
  }

-- Export:
return Interface

--[[
  2026-06-15
  2026-09-27
]]
