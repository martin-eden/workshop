-- Zero-padded index string, given max index

--[[
  Author: Martin Eden
  Last mod.: 2026-09-19
]]

--[[
  Data storage format

    1 [s] -- zero-padding format string
]]

local to_string
do
  local str_format = string.format

  to_string =
    function(Me, index)
      return str_format(Me[1], index)
    end
end

local Interface

local create
do
  local is_natural = request('!.number.is_natural')
  local get_num_dec_digits = request('!.number.get_num_dec_digits')
  local int_to_str = tostring
  local create_instance = request('!.table.create_instance')
  create =
    function(max_index)
      assert(is_natural(max_index))

      local zeroes_padding_format =
        '%0' .. int_to_str(get_num_dec_digits(max_index)) .. 'd'

      return create_instance({ zeroes_padding_format }, Interface)
    end
end

Interface =
  {
    create = create,
    ToString = to_string,
  }

-- Export:
return Interface

--[[
  2026-07-31
  2026-09-19
]]
