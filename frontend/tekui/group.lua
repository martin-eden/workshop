local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(header, overrides, ...)
    local result =
      tui.Group:new(
        {
          Width = 'fill',
          Height = 'auto',
          Legend = header,
        }
      )
    result.Children = {...}
    merge(result, overrides)

    return result
  end
