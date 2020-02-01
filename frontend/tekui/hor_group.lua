local group = request('group')
local merge = request('!.table.merge')

return
  function(...)
    local result = group(...)
    merge(
      result,
      {
        Orientation = 'horizontal',
      }
    )

    return result
  end
