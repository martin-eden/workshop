local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(header, overrides, ...)
    local params =
      merge(
        {
          Width = 'fill',
          Height = 'auto',
          Legend = header,
          Children = {...},
        },
        overrides
      )

    return tui.Group:new(params)
  end
