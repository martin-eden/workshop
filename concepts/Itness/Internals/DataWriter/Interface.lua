-- Data serialization functions

--[[
  Author: Martin Eden
  Last mod.: 2026-05-26
]]

--[[
  This class knows nothing about structure and just writes to output
  syntax-specific strings and does value serialization.
]]

-- Imports:
local get_values = request('!.table.get_values')
local map_values = request('!.table.map_values')
local list_to_string = request('!.concepts.list.to_string')
local lua_regexp_quote = request('!.lua.regexp.quote')

local Interface =
  {
    -- [Config] Output stream
    Output = { },

    -- [Config] Named syntax characters
    Syntax = { },

    -- [Main] Initialize state
    Init =
      function(Me)
        local SyntaxList = get_values(Me.Syntax)

        Me.IsSyntaxChar_Map = map_values(SyntaxList)

        Me.syntax_chars_regexp =
          '[' ..
          lua_regexp_quote(list_to_string(SyntaxList)) ..
          ']'
      end,

    -- [Main] Emit group opening character
    StartList =
      function(Me)
        Me.Output:Write(Me.Syntax.group_open_char)
      end,

    -- [Main] Emit group closing character
    EndList =
      function(Me)
        Me.Output:Write(Me.Syntax.group_close_char)
      end,

    -- [Main] Serialize string
    WriteLeaf = request('WriteLeaf'),

    -- [Internals]:
    IsSyntaxChar_Map = { },
    syntax_chars_regexp = '',
  }

-- Export:
return Interface

--[[
  2024 # #
]]
