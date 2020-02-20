local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(id, min, max, overrides)
    local params =
      merge(
        {
          Id = id,
          Min = min,
          Max = max,
        },
        overrides
      )

    return tui.Gauge:new(params)
  end
