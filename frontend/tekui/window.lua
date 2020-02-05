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
        },
        overrides
      )

    return tui.Window:new(params)
  end
