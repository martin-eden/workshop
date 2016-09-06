-- More optimal parsing of JSON syntax.

--[[
  About 8 times faster than strict syntax version. Optimization
  touched string and numbers. It was quite easy. Just change any
  is-not-choice or seq-list to corresponding regexp.

  2016-06-15
]]

local parser = request('^.^.parser')
local handy = parser.handy

local cho = handy.cho
local opt = handy.opt
local opt_rep_cho = handy.opt_rep_cho
local list = handy.list
local match = handy.match_pattern

local opt_spc =
  match('^[ \n\r\t]*')

local tok =
  function(...)
    local result =
      {
        opt_spc,
        ...
      }
    result[#result + 1] = opt_spc
    return result
  end

local null =
  tok({name = 'null', 'null'})

local boolean =
  tok({name = 'boolean', cho('true', 'false')})

local dec_digits_no_lead_zero =
  match([[^[1-9][%d]*]])

local dec_digits_any =
  match([[^[%d]+]])

local number =
  {
    name = 'number',
    opt('-'),
    cho(
      '0',
      dec_digits_no_lead_zero
    ),
    opt({'.', dec_digits_any}),
    opt(match('^[eE][%+%-]?'), dec_digits_any)
  }
number = tok(number)

local plain_string_chars =
  match([[^[^%c%\%"]*]])

local hex_dig =
  match('^[%dabcdefABCDEF]')

local utf_code_point =
  {'u', hex_dig, hex_dig, hex_dig, hex_dig}

local json_string =
  {
    name = 'string',
    '"',
    opt_rep_cho(
      plain_string_chars,
      {
        [[\]],
        cho('"', [[\]], '/', 'b', 'f', 'n', 'r', 't', utf_code_point)
      }
    ),
    '"'
  }
json_string = tok(json_string)

local array =
  {
    name = 'array',
    tok('['), opt(list('>value', tok(','))), tok(']')
  }

local value =
  cho(array, '>object', json_string, number, boolean, null)
value.inner_name = 'value'

local object =
  {
    name = 'object',
    tok('{'), opt(list({name = 'key', json_string}, tok(':'), {name = 'value', value}, tok(','))), tok('}')
  }
object.inner_name = 'object'

parser.finalize(object)

return object
