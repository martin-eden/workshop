return
  {
    node_recs = {},
    init = request('init'),
    serializer = request('^.lua_table.interface'),
    put_qualified_key = request('put_qualified_key'),
    serialize_subtable = request('serialize_subtable'),
    serialize = request('serialize'),
  }
