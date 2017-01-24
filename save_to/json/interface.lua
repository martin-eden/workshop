return
  {
    prepare = request('prepare'),
    serialize = request('serialize'),
    verify = request('verify'),

    init = request('init'),
    table_iterator = request('^.^.table.ordered_pass'),
    token_giver = request('^.^.compile.json.token_givers.readable'),
    string_adder = request('^.^.handy_mechs.string_adders.any'),
  }
