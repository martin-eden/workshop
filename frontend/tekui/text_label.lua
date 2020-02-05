local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(text, overrides)
    local params =
      merge(
        {
          Class = 'caption',
          Width = 'fill',
          Text = text,
        },
        overrides
      )

    return tui.Text:new(params)
  end
