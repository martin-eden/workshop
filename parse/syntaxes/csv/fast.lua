local parser = request('^.^.parser')
local handy = parser.handy

local opt = handy.opt
local list = handy.list
local rep = handy.rep
local cho = handy.cho
local is_not = handy.is_not
local match = handy.match_pattern

local opt_spc = match('^[ \t]*')
local string_chars = match('^[^%"]*')
local quoted_data =
  {
    opt_spc,
    {
      name = 'quoted_data',
      '"',
      opt(rep(cho('""', string_chars))),
      '"',
    },
    opt_spc
  }
local record_sep = {opt('\r'), '\n'}
local field_sep = ','
local unquoted_chars = match('^[^%,\r\n]*')
local unquoted_data =
  {
    name = 'unquoted_data',
    opt_spc,
    is_not('"'),
    unquoted_chars,
  }
local record =
  {
    name = 'record',
    list(
      opt(cho(quoted_data, unquoted_data)),
      field_sep
    )
  }
local csv_records =
  list(record, record_sep)

parser.finalize(csv_records)

return csv_records
