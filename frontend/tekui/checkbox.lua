local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(text, value, id, overrides)
    local params =
      {
        Text = text,
        Selected = value,
        Id = id,
        Width = 'fill',
      }
    local result = tui.CheckMark:new(params)
    merge(result, overrides)

    return result
  end
