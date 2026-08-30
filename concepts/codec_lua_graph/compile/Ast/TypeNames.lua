-- Type names for AST nodes

--[[
  Author: Martin Eden
  Last mod.: 2026-08-30
]]

--[[
  Design allows us to use any set of unique values instead of strings

  For example we can use integers.

  We use strings because we want comprehensible AST printout.
  But actual literals is not important for code.
]]

-- Export:
return
  {
    type_name = 'name',

    type_number = 'number',
    type_string = 'string',
    type_table = 'table',

    type_local = 'definition',
    type_assignment = 'indexed_assignment',
    type_return = 'emit',
  }

--[[
  2026-08-19
]]
