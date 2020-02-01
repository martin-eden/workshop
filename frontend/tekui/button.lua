local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(text, overrides)
    local result =
      tui.Text:new(
        {
          Mode = 'button',
          Class = 'button',
          Text = text,
          KeyCode = true,
        }
      )
    merge(result, overrides)

    return result
  end
