-- Lines indent/unindent methods

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local indent_chunk = '  '

-- Adds indentation chunk to every non-empty line
local indent =
  function(lines)
    for index = 1, lines:GetNumLines() do
      local line = lines:GetLineAt(index)
      if (line ~= '') then
        lines:SetLineAt(indent_chunk .. line, index)
      end
    end
  end

-- Remove indentation chunk from every line
local unindent
do
  local starts_with = request('!.string.starts_with')
  local str_sub = string.sub
  unindent =
    function(lines)
      for index = 1, lines:GetNumLines() do
        local line = lines:GetLineAt(index)
        if starts_with(line, indent_chunk) then
          lines:SetLineAt(str_sub(line, #indent_chunk + 1), index)
        end
      end
    end
end

-- Export:
return
  {
    Indent = indent,
    Unindent = unindent,
  }

--[[
  2024 #
  2026-04-24
  2026-04-26
]]
