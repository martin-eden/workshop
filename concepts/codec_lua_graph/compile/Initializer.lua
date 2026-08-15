-- Prepare serializer instance and output stream before serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-08-15
]]

--[[
  We have two data sources: "style" and "behavior flags".

  "style" determines general layout (compact one-liner, readable one-liner
  or readable multi-liner).

  "behavior flags" are settings for Tree Serializer. And technically
  they are independent from "style".

  * If caller passed nothing, we'll use some default style.
  * We'll still pre-set behavior flags from style.
  * If caller passed some behavior flags, we'll override our
    pre-set flags.
]]

local DefaultOptions =
  {
    style = 'readable_long',

    table_iterator = request('!.table.ordered_pass'),
  }

local configure_style
do
  local StyleToBehavior =
    {
      ['minimal'] =
        {
          use_compact_indices = true,
          use_compact_sequences = true,
          omit_tail_delimiter = true,
        },
      ['readable_short'] =
        {
          use_compact_indices = true,
          use_compact_sequences = true,
          omit_tail_delimiter = true,
        },
      ['readable_long'] =
        {
          use_compact_indices = true,
          use_compact_sequences = false,
          omit_tail_delimiter = false,
        },
    }

  local Writers_Map =
    {
      ['minimal'] = request('Writers.Minimal'),
      ['readable_short'] = request('Writers.Readable_Short'),
      ['readable_long'] = request('Writers.Readable_Long'),
    }

  local Notify_Map
  do
    local notify_default = function(event_name, Output) end
    Notify_Map =
      {
        ['minimal'] = notify_default,
        ['readable_short'] = notify_default,
        ['readable_long'] = request('Formatters.readable_long'),
      }
  end

  local set_field =
    function(BaseTable, OptTable, field_name)
      if not is_table(OptTable) then return end
      if is_nil(OptTable[field_name]) then return end

      BaseTable[field_name] = OptTable[field_name]
    end

  configure_style =
    function(Serializer, Output, style_str, ArgOptions)
      local Writer_Module = Writers_Map[style_str]
      local Behavior = StyleToBehavior[style_str]

      if not is_table(Writer_Module) or not is_table(Behavior) then
        error('No writer/behavior for given style.')
      end

      Serializer.Output = Output
      Serializer.Writer = Writer_Module.create(Output)

      Serializer.use_compact_indices = Behavior.use_compact_indices
      Serializer.use_compact_sequences = Behavior.use_compact_sequences
      Serializer.omit_tail_delimiter = Behavior.omit_tail_delimiter

      set_field(Serializer, ArgOptions, 'use_compact_indices')
      set_field(Serializer, ArgOptions, 'use_compact_sequences')
      set_field(Serializer, ArgOptions, 'omit_tail_delimiter')

      Serializer.notify = Notify_Map[style_str]
    end
end

--[=[
  There is syntactic clash between "long quote" and "table index":

  ['abc'] -- OK, [[[abc]]] -- not OK

  wrap_output() modifies :Write() function of stream to convert
  listed case to "[ [[abc]]]".

  Problem is that Lua syntax flaw.

  Code below is workaround for our use cases in graph serializer.
  It will emit '[ [[' for calls ('[' '[[') but
  for calls ('[' '[' '[') it will emit '[ [ ['.
]=]
local wrap_output =
  function(Output)
    local original_write

    local wrapped_write
    do
      local opening_bracket
      local space
      do
        local Ascii = request('!.concepts.Ascii.Chars')
        opening_bracket = Ascii.opening_bracket
        space = Ascii.space
      end
      local str_sub = string.sub
      local last_char = ''

      wrapped_write =
        function(Output, str)
          local next_char = str_sub(str, 1, 1)

          if
            (last_char == opening_bracket) and
            (next_char == opening_bracket)
          then
            original_write(Output, space)
          end

          original_write(Output, str)

          last_char = str_sub(str, -1)
        end
    end

    original_write = Output.Write
    Output.Write = wrapped_write

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
  2026-08-15
]]
