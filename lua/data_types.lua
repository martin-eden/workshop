-- Return table sequence with type names of all Lua data types

--[[
  Output

    table

      Sequence of strings with type names. As they are returned
      by type() function.

  Note

    This list is used in code generation.
]]

-- Last mod.: 2024-03-02

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
