local parser = request('!.mechs.parser')
local handy = parser.handy
local opt_rep = handy.opt_rep
local cho = handy.cho
local list = handy.list
local match_regexp = handy.match_regexp

local field_sep_char = ','

local opt_spc = match_regexp('[ \t]*')

local quoted_data =
  {
    opt_spc,
    {
      name = 'quoted_data',
      '"',
      opt_rep(
        cho(
          match_regexp('[^"]+'),
          '""'
        )
      ),
      '"',
    },
    opt_spc
  }

local unquoted_data =
  {
    name = 'unquoted_data',
    match_regexp('[^' .. field_sep_char .. '\r\n]*'),
  }

return
  list(
    {
      name = 'record',
      list(
        cho(quoted_data, unquoted_data),
        {name = 'field_sep', field_sep_char}
      )
    },
    match_regexp('[\r]?\n')
  )
