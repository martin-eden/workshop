-- Itness codec interface

--[[
  Author: Martin Eden
  Last mod.: 2026-05-26
]]

-- Imports:
local Syntax = request('Syntax')
local parse = request('parse')
local compile = request('compile')

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
