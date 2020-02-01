local text_label = request('text_label')
local merge = request('!.table.merge')

return
  function(...)
    local result = text_label(...)
    merge(result, {Style = 'text-align: right'})
    return result
  end
