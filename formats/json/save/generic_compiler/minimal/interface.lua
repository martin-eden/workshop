return
  {
    init = request('init'),
    get_struc = request('get_struc'),
    --
    handlers = request('handlers.interface'),
    table_iterator = request('!.table.ordered_pass'),
  }
