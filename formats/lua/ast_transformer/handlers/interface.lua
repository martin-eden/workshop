local result =
  {
    expression = request('expression'),
  }

local merge = request('!.table.merge')
merge(result, request('expressions.interface'))
merge(result, request('statements.interface'))

return result
