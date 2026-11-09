-- Zero-padded index string, given max index

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Data storage format

    [s] -- zero-padding format string
]]

local to_string
do
  local str_format = string.format
  to_string =
    function(me, index)
      return str_format(me[1], index)
    end
end

local interface

local create
do
  local is_natural = request('!.number.is_natural')
  local get_num_dec_digits = request('!.number.get_num_dec_digits')
  local int_to_str = tostring
  local attach_methods = request('!.table.attach_methods')
  create =
    function(max_index)
      assert(is_natural(max_index))

      local zeroes_padding_format =
        '%0' .. int_to_str(get_num_dec_digits(max_index)) .. 'd'

      local me = { zeroes_padding_format }
      attach_methods(me, interface)

      return me
    end
end

interface =
  {
    create = create,
    to_string = to_string,
  }

-- Export:
return interface

--[[
  2026-07-31
  2026-09-19
]]
