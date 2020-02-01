local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(text, overrides)
    local result =
      tui.Text:new(
        {
          Class = 'caption',
          Width = 'fill',
          Text = text,
        }
      )
    merge(result, overrides)

    return result
  end
