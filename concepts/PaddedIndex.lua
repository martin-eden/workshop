-- Zero-padded index string, given max index

--[[
  Author: Martin Eden
  Last mod.: 2026-07-31
]]

local is_natural = request('!.number.is_natural')

--[[
  Data storage format

    1 [i] Max index (natural number)
    2 [s] Zero-padding format string for that max index
]]

local get_max_index =
  function(Me)
    return Me[1]
  end

local get_format =
  function(Me)
    return Me[2]
  end

local to_string =
  function(Me, index)
    assert(is_natural(index))
    assert(index <= get_max_index(Me))

    local str_format = string.format

    return str_format(get_format(Me), index)
  end

local Interface
Interface =
  {
    ToString = to_string,

    create =
      function(max_index)
        assert(is_natural(max_index))

        local zeroes_padding_format
        do
          local get_num_dec_digits = request('!.number.get_num_dec_digits')
          local int_to_str = tostring

          local num_digits = get_num_dec_digits(max_index)

          zeroes_padding_format = '%0' .. int_to_str(num_digits) .. 'd'
        end

        local create_instance = request('!.table.create_instance')

        local Core = { max_index, zeroes_padding_format }

        return create_instance(Core, Interface)
      end,
  }

-- Export:
return Interface

--[[
  2026-07-31
]]
