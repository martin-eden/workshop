local group = request('group')
local merge = request('!.table.merge')

return
  function(...)
    local result = group(...)
    merge(
      result,
      {
        Orientation = 'vertical',
      }
    )

    return result
  end
