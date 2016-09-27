local parser = request('^.parser')
local handy = parser.handy

local opt_spc = handy.match_pattern('[ \t]*')

local quoted_data =
  {
    opt_spc,
    {
      name = 'quoted_data',
      '"',
      handy.opt(
        handy.rep(
          handy.cho1(
            handy.match_pattern('[^"]+'),
            '""'
          )
        )
      ),
      '"',
    },
    opt_spc
  }

local unquoted_data =
  {
    name = 'unquoted_data',
    opt_spc,
    handy.match_pattern('[^,\r\n]*'),
  }

local field_sep = {name = 'field_sep', ','}
local record =
  {
    name = 'record',
    handy.list(
      handy.opt(
        handy.cho1(
          quoted_data,
          unquoted_data
        )
      ),
      field_sep
    )
  }

local record_sep = handy.match_pattern('[\r]?\n')
local csv_records = handy.list(record, record_sep)

parser.optimize(csv_records)

return csv_records
