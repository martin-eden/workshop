-- More optimal parsing of JSON syntax.

--[[
  About 8 times faster than strict syntax version. Optimization
  touched string and numbers. It was quite easy. Just change any
  is-not-choice or seq-list to corresponding regexp.

  2016-06-15
]]

local processor_handy = request('!.mechs.processor.handy')
local cho = processor_handy.cho
local opt = processor_handy.opt
local opt_rep = processor_handy.opt_rep
local list = processor_handy.list

local match_regexp = request('!.mechs.parser.handy').match_regexp

local opt_spc = match_regexp('[ \n\r\t]*')

local open_brace = '{'
local close_brace = {opt_spc, '}'}
local open_bracket = '['
local close_bracket = {opt_spc, ']'}
local colon = {opt_spc, ':'}
local comma = {opt_spc, ','}

local null =
  {
    opt_spc,
    {
      name = 'null',
      'null',
    }
  }

local boolean =
  {
    opt_spc,
    {
      name = 'boolean',
      cho('true', 'false'),
    }
  }

local number =
  {
    opt_spc,
    {
      name = 'number',
      opt('-'),
      cho('0', match_regexp('[1-9]%d*')),
      opt(match_regexp('%.%d+')),
      opt(match_regexp('[eE][%+%-]?%d+'))
    },
  }

local json_string =
  {
    opt_spc,
    {
      name = 'string',
      '"',
      opt_rep(
        cho(
          match_regexp([[[^%c%\%"]+]]),
          {
            [[\]],
            cho(
              match_regexp([=[[%"%\%/bfnrt]]=]),
              match_regexp('u%x%x%x%x')
            )
          }
        )
      ),
      '"'
    }
  }

local array =
  {
    opt_spc,
    {
      name = 'array',
      open_bracket,
      opt(list('>value', comma)),
      close_bracket
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

local optimize = request('!.mechs.processor.optimize')
optimize(object)

return cho(object, array)
