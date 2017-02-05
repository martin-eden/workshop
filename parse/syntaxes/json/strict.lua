-- Maximum explicit definition of syntax.

-- Intended to verify results from optimized syntaxes

local parser = request('^.^.parser')
local handy = parser.handy

local cho1 = handy.cho1
local opt_rep = handy.opt_rep
local opt = handy.opt
local rep = handy.rep
local opt_cho = handy.opt_cho
local is_not = handy.is_not
local opt_rep = handy.opt_rep
local list = handy.list

local opt_spc =
  opt_rep(cho1(' ', '\n', '\r', '\t'))

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
  tok({name = 'boolean', cho1('true', 'false')})

local zero_digit =
  '0'
local nonzero_dec_digit =
  cho1('9', '8', '7', '6', '5', '4', '3', '2', '1')
local dec_digit =
  cho1(nonzero_dec_digit, zero_digit)

local number =
  {
    name = 'number',
    opt('-'),
    cho1(
      zero_digit,
      {nonzero_dec_digit, opt_rep(dec_digit)}
    ),
    opt({'.', rep(dec_digit)}),
    opt(cho1('e', 'E'), opt_cho('+', '-'), rep(dec_digit))
  }
number = tok(number)

local control_char =
  cho1(
    '\x00', '\x01', '\x02', '\x03', '\x04', '\x05', '\x06', '\x07',
    '\x08', '\x09', '\x0a', '\x0b', '\x0c', '\x0d', '\x0e', '\x0f',
    '\x10', '\x11', '\x12', '\x13', '\x14', '\x15', '\x16', '\x17',
    '\x18', '\x19', '\x1a', '\x1b', '\x1c', '\x1d', '\x1e', '\x1f'
  )
local any_char =
  function(s, s_pos)
    if (s_pos <= #s) then
      return true, s_pos + 1
    end
  end

local hex_only_digit =
  cho1('a', 'b', 'c', 'd', 'e', 'f', 'A', 'B', 'C', 'D', 'E', 'F')
local hex_dig =
  cho1(dec_digit, hex_only_digit)

local utf_code_point =
  {'u', hex_dig, hex_dig, hex_dig, hex_dig}

local json_string =
  {
    name = 'string',
    '"',
    opt_rep(
      cho1(
        {is_not('"', [[\]], control_char), any_char},
        {
          [[\]],
          cho1('"', [[\]], '/', 'b', 'f', 'n', 'r', 't', utf_code_point)
        }
      )
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
  cho1(
    number,
    json_string,
    array,
    '>object',
    boolean,
    null
  )
value.inner_name = 'value'

local object =
  {
    name = 'object',
    tok('{'), opt(list({name = 'key', json_string}, tok(':'), {name = 'value', value}, tok(','))), tok('}')
  }
object.inner_name = 'object'

return object
