local chunk_name = 'lua_keywords'

local map_values = request('^.table.map_values')

local lua_keywords =
  map_values(
    {
      'nil',
      'true',
      'false',
      'not',
      'and',
      'or',
      'do',
      'end',
      'local',
      'function',
      'goto',
      'if',
      'then',
      'elseif',
      'else',
      'while',
      'repeat',
      'until',
      'for',
      'in',
      'break',
      'return',
    }
  )

tribute(chunk_name, lua_keywords)
