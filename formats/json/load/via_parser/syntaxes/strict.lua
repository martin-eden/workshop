-- Maximum explicit definition of syntax.

-- Intended to verify results from optimized syntaxes

local processor_handy = request('!.mechs.processor.handy')
local cho = processor_handy.cho
local opt_rep = processor_handy.opt_rep
local opt = processor_handy.opt
local rep = processor_handy.rep
local is_not = processor_handy.is_not
local opt_rep = processor_handy.opt_rep
local list = processor_handy.list

local any_char = request('!.mechs.parser.handy').any_char

local opt_spc =
  opt_rep(cho(' ', '\n', '\r', '\t'))

local open_brace = '{'
local close_brace = {opt_spc, '}'}
local open_bracket = '['
local close_bracket = {opt_spc, ']'}
local colon = {opt_spc, ':'}
local comma = {opt_spc, ','}

local null =
  {opt_spc, {name = 'null', 'null'}}

local boolean =
  {opt_spc, {name = 'boolean', cho('true', 'false')}}

local zero_digit = '0'
local nonzero_dec_digit = cho('9', '8', '7', '6', '5', '4', '3', '2', '1')
local dec_digit = cho(nonzero_dec_digit, zero_digit)

local number =
  {
    opt_spc,
    {
      name = 'number',
      opt('-'),
      cho(
        zero_digit,
        {nonzero_dec_digit, opt_rep(dec_digit)}
      ),
      opt({'.', rep(dec_digit)}),
      opt(cho('e', 'E'), opt(cho('+', '-')), rep(dec_digit))
    },
  }

local control_char =
  cho(
    '\x00', '\x01', '\x02', '\x03', '\x04', '\x05', '\x06', '\x07',
    '\x08', '\x09', '\x0a', '\x0b', '\x0c', '\x0d', '\x0e', '\x0f',
    '\x10', '\x11', '\x12', '\x13', '\x14', '\x15', '\x16', '\x17',
    '\x18', '\x19', '\x1a', '\x1b', '\x1c', '\x1d', '\x1e', '\x1f'
  )

local hex_only_digit =
  cho('a', 'b', 'c', 'd', 'e', 'f', 'A', 'B', 'C', 'D', 'E', 'F')
local hex_dig =
  cho(dec_digit, hex_only_digit)
local utf_code_point =
  {'u', hex_dig, hex_dig, hex_dig, hex_dig}

local json_string =
  {
    opt_spc,
    {
      name = 'string',
      '"',
      opt_rep(
        cho(
          {is_not(cho('"', [[\]], control_char)), any_char},
          {
            [[\]],
            cho('"', [[\]], '/', 'b', 'f', 'n', 'r', 't', utf_code_point)
          }
        )
      ),
      '"'
    },
  }

local array =
  {
    opt_spc,
    {
      name = 'array',
      open_bracket, opt(list('>value', comma)), close_bracket
    },
  }

local object =
  {
    opt_spc,
    {
      name = 'object',
      open_brace,
      opt(list(json_string, colon, '>value', comma)),
      close_brace,
    },
  }

local value =
  cho(
    number,
    json_string,
    array,
    object,
    boolean,
    null
  )
value.inner_name = 'value'

local link = request('!.mechs.processor.link')
link(value)

return object
