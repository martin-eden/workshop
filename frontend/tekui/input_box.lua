local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(text, id, overrides)
    local result =
      tui.Input:new(
        {
          Text = text,
          Id = id,
          Width = 'free',
          MinWidth = 0,
        }
      )
    merge(result, overrides)

    return result
  end
