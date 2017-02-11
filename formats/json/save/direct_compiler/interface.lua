return
  {
    init = request('init'),
    serialize = request('serialize'),
    get_result = request('get_result'),

    table_iterator = request('!.table.ordered_pass'),
    printer = request('!.mechs.text_block.interface'),
    tokens = request('tokens.readable.interface'),
  }
