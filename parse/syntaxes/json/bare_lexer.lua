local lexer = request('^.^.json.lexer')
local parser = request('^.^.parser')
local handy = parser.handy

local is_null = {name = 'null', lexer.is_null}
local is_boolean = {name = 'boolean', lexer.is_boolean}
local is_number = {name = 'number', lexer.is_number}
local is_string = {name = 'string', lexer.is_string}
local is_spaces = lexer.is_spaces
local is_open_bracket = {name = 'open_bracket', lexer.is_open_bracket}
local is_close_bracket = {name = 'close_bracket', lexer.is_close_bracket}
local is_open_brace = {name = 'open_brace', lexer.is_open_brace}
local is_close_brace = {name = 'close_brace', lexer.is_close_brace}
local is_comma = {name = 'comma', lexer.is_comma}
local is_colon = {name = 'colon', lexer.is_colon}

local result =
  handy.rep(
    handy.cho1(
      is_spaces,
      is_number,
      is_string,
      is_comma,
      is_colon,
      is_open_bracket,
      is_close_bracket,
      is_open_brace,
      is_close_brace,
      is_boolean,
      is_null
    )
  )

-- local table_to_str = request('^.^.^.save_to.lua_table')
-- print('grammar', table_to_str(result))

return result
