local map_values = request('^.^.table.map_values')

return
  map_values(
    {
      'nil',
      'boolean',
      'number',
      'string',
      'function',
      'thread',
      'userdata',
      'table',
    }
  )
