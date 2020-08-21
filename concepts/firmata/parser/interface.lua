local merge = request('!.table.merge')

local result =
  {
    parse = request('parse'),
    --
    stream = '',
  }

merge(result, request('implementation.interface'))

return result
