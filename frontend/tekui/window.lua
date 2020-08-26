local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(title, overrides, content)
    local params =
      merge(
        {
          Id = 'main-window',
          Title = title,
          Status = 'hide',
          HideOnEscape = true,
          Orientation = 'vertical',
          Children = {content},
          Width = 'free',
          Height = 'free',
        },
        overrides
      )

    return tui.Window:new(params)
  end
