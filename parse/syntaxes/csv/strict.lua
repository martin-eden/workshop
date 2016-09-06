local parser = request('^.^.parser')
local handy = parser.handy

local opt = handy.opt
local list = handy.list
local rep = handy.rep
local cho = handy.cho
local is_not = handy.is_not

local opt_spc = opt(rep(cho(' ', '\t')))

local any_char =
  function(s, s_pos)
    if (s:sub(s_pos, s_pos) ~= '') then
      return true, s_pos + 1
    end
  end

local record_sep = {opt('\r'), '\n'}
local field_sep = ','

local quoted_data =
  {
    opt_spc,
    {
      name = 'quoted_data',
      '"',
      opt(rep(cho('""', {is_not('"'), any_char}))),
      '"',
    },
    opt_spc
  }
local unquoted_data =
  {
    name = 'unquoted_data',
    opt_spc,
    is_not('"'),
    opt(rep(is_not(field_sep, record_sep), any_char))
  }
local record =
  {
    name = 'record',
    opt(
      list(
        opt(cho(quoted_data, unquoted_data)),
        field_sep
      )
    )
  }
local csv_records =
  opt(list(record, record_sep))

parser.finalize(csv_records)

return csv_records
