local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(title, overrides, content)
    local result =
      tui.Window:new(
        {
          Id = 'main-window',
          Title = title,
          Status = 'hide',
          HideOnEscape = true,
          Orientation = 'vertical',
          Children = {content},
        }
      )
    merge(result, overrides)

    return result
  end
