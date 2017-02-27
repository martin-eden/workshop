-- More optimal parsing of JSON syntax.

--[[
  About 8 times faster than strict syntax version. Optimization
  touched string and numbers. It was quite easy. Just change any
  is-not-choice or seq-list to corresponding regexp.

  2016-06-15
]]

local parser = request('!.mechs.parser')
local handy = parser.handy

local cho = handy.cho
local opt = handy.opt
local opt_rep = handy.opt_rep
local list = handy.list
local match_regexp = handy.match_regexp

local opt_spc =
  match_regexp('[ \n\r\t]*')

local null =
  {opt_spc, {name = 'null', 'null'}}

local boolean =
  {opt_spc, {name = 'boolean', cho('true', 'false')}}

local number =
  {
    opt_spc,
    {
      name = 'number',
      opt('-'),
      cho('0', match_regexp('[1-9]%d*')),
      opt(match_regexp('%.%d+')),
      opt(match_regexp('[eE][%+%-]?%d+'))
    }
  }

local utf_code_point =
  'u' .. ('[0-9a-fA-F]'):rep(4)

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
              match_regexp(utf_code_point)
            )
          }
        )
      ),
      '"'
    }
  }

local array =
  {
    name = 'array',
    opt_spc, '[',
    opt(list('>value', {opt_spc, ','})),
    opt_spc, ']',
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
    opt_spc, '{',
    opt(
      list(
        json_string, opt_spc, ':', value,
        {opt_spc, ','}
      )
    ),
    opt_spc, '}',
  }
object.inner_name = 'object'

parser.link(object)

return object
