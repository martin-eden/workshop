-- Return right-aligned text label object

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local text_label = request('text_label')
local force_merge = request('!.table.merge_and_patch')

local create_text_label_ra =
  function(text, Overrides)
    local Params = { Style = 'text-align: right' }

    force_merge(Params, Overrides)

    return text_label(text, Params)
  end

-- Export:
return create_text_label_ra

--[[
  2020-02
]]
