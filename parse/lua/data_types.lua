local map_values = request('^.^.table.map_values')

local data_types =
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

return data_types
