-- Return list with names of all Lua data types

--[[
  Output

    table

      List of strings with type names as they are returned
      by type() function.

  Note

    Used in code generation.
]]

-- Last mod.: 2024-08-06

return
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

--[[
  2018-02
]]
