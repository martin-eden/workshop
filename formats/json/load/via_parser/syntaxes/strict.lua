-- Maximum explicit definition of syntax.

-- Intended to verify results from optimized syntaxes

local parser = request('!.mechs.parser')
local handy = parser.handy

local cho = handy.cho
local opt_rep = handy.opt_rep
local opt = handy.opt
local rep = handy.rep
local opt_cho = handy.opt_cho
local is_not = handy.is_not
local opt_rep = handy.opt_rep
local list = handy.list

local opt_spc =
  opt_rep(cho(' ', '\n', '\r', '\t'))

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

local zero_digit =
  '0'
local nonzero_dec_digit =
  cho('9', '8', '7', '6', '5', '4', '3', '2', '1')
local dec_digit =
  cho(nonzero_dec_digit, zero_digit)

local number =
  {
    name = 'number',
    opt('-'),
    cho(
      zero_digit,
      {nonzero_dec_digit, opt_rep(dec_digit)}
    ),
    opt({'.', rep(dec_digit)}),
    opt(cho('e', 'E'), opt_cho('+', '-'), rep(dec_digit))
  }
number = tok(number)

local control_char =
  cho(
    '\x00', '\x01', '\x02', '\x03', '\x04', '\x05', '\x06', '\x07',
    '\x08', '\x09', '\x0a', '\x0b', '\x0c', '\x0d', '\x0e', '\x0f',
    '\x10', '\x11', '\x12', '\x13', '\x14', '\x15', '\x16', '\x17',
    '\x18', '\x19', '\x1a', '\x1b', '\x1c', '\x1d', '\x1e', '\x1f'
  )
local any_char =
  function(stream)
    return stream:block_read(1)
  end

local hex_only_digit =
  cho('a', 'b', 'c', 'd', 'e', 'f', 'A', 'B', 'C', 'D', 'E', 'F')
local hex_dig =
  cho(dec_digit, hex_only_digit)

local utf_code_point =
  {'u', hex_dig, hex_dig, hex_dig, hex_dig}

local json_string =
  {
    name = 'string',
    '"',
    opt_rep(
      cho(
        {is_not('"', [[\]], control_char), any_char},
        {
          [[\]],
          cho('"', [[\]], '/', 'b', 'f', 'n', 'r', 't', utf_code_point)
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
  cho(
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
    tok('{'), opt(list(json_string, tok(':'), value, tok(','))), tok('}')
  }
object.inner_name = 'object'

return object
