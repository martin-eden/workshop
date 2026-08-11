-- Prepare serializer instance and output stream before serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

local DefaultOptions =
  {
    style = 'readable_long',

    table_iterator = request('!.table.ordered_pass'),
  }

local configure_style
do
  local formatter_minimal = request('Formatters.minimal')
  local formatter_readable_short = request('Formatters.readable_short')
  local formatter_readable_long = request('Formatters.readable_long')

  local set_style =
    function(style_str, Serializer)
      local Formaters_Map =
        {
          ['minimal'] = formatter_minimal,
          ['readable_short'] = formatter_readable_short,
          ['readable_long'] = formatter_readable_long,
        }

      local formatter = Formaters_Map[style_str]

      if not is_function(formatter) then
        error('No formatter for given style.')
      end

      formatter(Serializer.Config)
    end

  local set_field =
    function(BaseTable, OptTable, field_name)
      if not is_table(OptTable) then return end
      if is_nil(OptTable[field_name]) then return end

      BaseTable[field_name] = OptTable[field_name]
    end

  configure_style =
    function(Serializer, style_str, ArgOptions)
      set_style(style_str, Serializer)

      local Config = Serializer.Config

      set_field(Config, ArgOptions, 'use_compact_indices')
      set_field(Config, ArgOptions, 'use_compact_sequences')
      set_field(Config, ArgOptions, 'omit_tail_delimiter')
    end
end

--[=[
  There is syntactic clash between "long quote" and "table index":

  ['abc'] -- OK, [[[abc]]] -- NOK

  This code converts last case to "[ [[abc]]]".
]=]
local wrap_output =
  function(Output)
    local original_write = Output.Write
    local last_char = ''

    Output.Write =
      function(Output, str)
        local next_char = string.sub(str, 1, 1)

        if (last_char == '[') and (next_char == '[') then
          original_write(Output, ' ')
        end

        original_write(Output, str)

        last_char = string.sub(str, -1)
      end

    return original_write
  end

local unwrap_output =
  function(Output, original_write)
    Output.Write = original_write
  end

local Interface =
  {
    DefaultOptions = DefaultOptions,

    configure_style = configure_style,

    wrap_output = wrap_output,
    unwrap_output = unwrap_output,
  }

-- Export:
return Interface

--[[
  2016 #
  2017 #
  2018 #
  2026 # # # # #
  2026-08-11
]]
