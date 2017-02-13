local parser = request('^.^.mechs.parser')
local handy = parser.handy

local field_sep_char = '&'
local fields_section_start_char = '?'
local key_val_delim_char = '='

local any_char =
  function(s, s_pos)
    if (s_pos <= #s) then
      return true, s_pos + 1
    end
  end

return
  {
    name = 'record',
    {
      {
        name = 'base_url',
        handy.rep({handy.is_not(fields_section_start_char), any_char}),
      },
      handy.opt(
        fields_section_start_char,
        handy.list(
          {
            name = 'key',
            handy.rep({handy.is_not(key_val_delim_char), any_char}),
          },
          key_val_delim_char,
          {
            name = 'value',
            handy.opt_rep({handy.is_not(field_sep_char), any_char}),
          },
          field_sep_char
        )
      )
    }
  }