-- Return format settings for given format label

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

-- Imports:
local Formats = request('Internals.Formats')

local get_format_settings =
  function(format_label)
    for _, Rec in ipairs(Formats) do
      if (Rec.label == format_label) then
        return Rec.Settings
      end
    end

    error('Format label is not found.')
  end

-- Export:
return get_format_settings

--[[
  2025-03-30
  2026-05-31
]]
