-- Itness codec interface

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

-- Imports:
local Syntax = request('Codec_Itness.Syntax')
local parse = request('Codec_Itness.parse')
local compile = request('Codec_Itness.compile')

local Interface =
  {
    -- Parse input to strings tree
    Parse =
      function(Me, Input)
        return parse(Input, Syntax)
      end,

    -- Compile strings tree to output
    Compile =
      function(Me, Tree, Output)
        compile(Tree, Output, Syntax)
      end,
  }

-- Export:
return Interface

--[[
  2026-05-23
]]
