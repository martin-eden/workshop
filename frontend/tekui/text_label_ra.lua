local text_label = request('text_label')
local merge = request('!.table.merge')

return
  function(text, overrides)
    overrides =
      merge(
        {Style = 'text-align: right'},
        overrides
      )

    return text_label(text, overrides)
  end
