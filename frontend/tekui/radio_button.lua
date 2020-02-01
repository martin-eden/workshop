local tui = require('tek.ui')
local merge = request('!.table.merge')

return
  function(text, value, id, overrides)
    local result =
      tui.RadioButton:new(
        {
          Text = text,
          Selected = value,
          Id = id,
        }
      )
    merge(result, overrides)

    return result
  end
