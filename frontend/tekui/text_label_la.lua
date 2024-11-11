-- Return left-aligned text label object

-- Last mod.: 2024-11-11

local text_label = request('text_label')
local force_merge = request('!.table.merge_and_patch')

return
  function(text, overrides)
    overrides =
      force_merge(
        { Style = 'text-align: left' },
        overrides
      )

    return text_label(text, overrides)
  end

--[[
  2020-08
]]
