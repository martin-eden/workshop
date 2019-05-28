local merge = request('!.table.merge')

local result =
  {
    request = request('request.interface'),
    reply = request('reply.interface'),
  }
merge(result, request('implementation.interface'))

return result
