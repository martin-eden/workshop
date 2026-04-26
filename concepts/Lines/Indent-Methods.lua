-- Lines indent/unindent methods

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

-- Imports:
local starts_with = request('!.string.starts_with')

local indent_chunk = '  '

-- Adds indentation chunk to every non-empty line
local Indent =
  function(Lines)
    for index = 1, Lines:GetNumLines() do
      local line = Lines:GetLineAt(index)
      if (line ~= '') then
        Lines:SetLineAt(indent_chunk .. line, index)
      end
    end
  end

-- Just removes indentation chunk from every line. If it can.
local Unindent =
  function(Lines)
    for index = 1, Lines:GetNumLines() do
      local line = Lines:GetLineAt(index)
      if starts_with(line, indent_chunk) then
        Lines:SetLineAt(string.sub(line, #indent_chunk + 1), index)
      end
    end
  end

-- Exports:
return
  {
    Indent = Indent,
    Unindent = Unindent,
  }

--[[
  2024 #
  2026-04-24
  2026-04-26
]]
