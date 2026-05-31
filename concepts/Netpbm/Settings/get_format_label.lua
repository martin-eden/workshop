-- Return format label string for given settings

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

--[[
  Returns format label string ("P1", "P2", .. , "P6") for given table
  with types of data encoding and color format.
]]

-- Imports:
local Formats = request('Internals.Formats')

local get_format_label =
  function(GivenSettings)
    local num_channels = GivenSettings.num_channels

    local use_text_storage = true
    if not is_nil(GivenSettings.is_text_storage) then
      use_text_storage = GivenSettings.is_text_storage
    end

    local num_channel_values = 256
    if not is_nil(GivenSettings.num_channel_values) then
      num_channel_values = GivenSettings.num_channel_values
    end

    for _, Rec in ipairs(Formats) do
      if
        (Rec.Settings.num_channels == num_channels) and
        (Rec.Settings.is_text_storage == use_text_storage) and
        (
          is_nil(Rec.Settings.num_channel_values) or
          (Rec.Settings.num_channel_values >= num_channel_values)
        )
      then
        return Rec.label
      end
    end

    error('Format label is not found.')
  end

-- Export:
return get_format_label

--[[
  2025-03-29
  2026-05-31
]]
