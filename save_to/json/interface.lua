return
  {
    table_iterator = request('^.^.table.ordered_pass'),
    token_giver = request('^.^.compile.json.token_givers.readable'),
    string_adder = request('^.^.handy_mechs.string_adders').default,
    init = request('init'),
    prepare = request('prepare'),
    verify = request('verify'),
    serialize = request('serialize'),
  }
