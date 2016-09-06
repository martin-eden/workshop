return
  {
    always_index_keys = false,
    name_giver = request('^.^.handy_mechs.name_giver'),
    table_iterator = request('^.^.table.ordered_pass'),
    string_adder = request('^.^.handy_mechs.string_adders').default,
    token_giver = request('^.^.compile.lua.token_givers').default,
    init = request('init'),
    serialize_key = request('serialize_key'),
    serialize_key_value = request('serialize_key_value'),
    serialize = request('serialize'),
  }
