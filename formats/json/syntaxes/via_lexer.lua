local lexer = request('^.parse.lexer')
local parser = request('^.^.^.mechs.parser')
local handy = parser.handy

local is_null = {name = 'null', lexer.is_null}
local is_boolean = {name = 'boolean', lexer.is_boolean}
local is_number = {name = 'number', lexer.is_number}
local is_string = {name = 'string', lexer.is_string}
local is_spaces = lexer.is_spaces
local is_open_bracket = {handy.opt(is_spaces), lexer.is_open_bracket}
local is_close_bracket = {handy.opt(is_spaces), lexer.is_close_bracket}
local is_open_brace = {handy.opt(is_spaces), lexer.is_open_brace}
local is_close_brace = {handy.opt(is_spaces), lexer.is_close_brace}
local is_comma = {handy.opt(is_spaces), lexer.is_comma}
local is_colon = {handy.opt(is_spaces), lexer.is_colon}

local array =
  {
    name = 'array',
    is_open_bracket,
    handy.opt(handy.list('>value', is_comma)),
    is_close_bracket
  }

local value =
  {
    inner_name = 'value',
    handy.opt(is_spaces),
    handy.cho1(
      -- ordering is important for final performance
      is_number,
      is_string,
      array,
      '>object',
      is_boolean,
      is_null
    ),
  }

local object =
  {
    name = 'object',
    is_open_brace,
    handy.opt(
      handy.list(
        handy.opt(is_spaces),
        is_string,
        is_colon,
        value,
        is_comma
      )
    ),
    is_close_brace,
  }
object.inner_name = 'object'

-- local table_to_str = request('^.^.^.save_to.lua_table')
-- print('grammar', table_to_str(object))

return object
