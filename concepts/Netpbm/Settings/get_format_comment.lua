-- Return comment string for given format label

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

-- Imports:
local Formats = request('Internals.Formats')

local get_format_comment =
  function(format_label)
    for _, Rec in ipairs(Formats) do
      if (Rec.label == format_label) then
        return Rec.comment
      end
    end

    error('Format label is not found.')
  end

-- Export:
return get_format_comment

--[[
  2026-05-31
]]
