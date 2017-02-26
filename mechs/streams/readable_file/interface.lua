local merge = request('!.table.merge')
return
  merge(
    new(request('^.readable.interface')),
    {
      init = request('init'),
      get_position = request('get_position'),
      set_position = request('set_position'),
      read = request('read'),
      f = nil,
    }
  )
