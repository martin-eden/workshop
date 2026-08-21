-- Prepare serializer instance and output stream before serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-08-20
]]

--[[
  We have two data sources: "style" and "behavior flags".

  "style" determines general layout (one-liner, multi-liner).
  It determines amount of whitespaces.

  "behavior flags" determines amount of additional tokens.

  For example in "{1,}", "," is additional token controlled by
  "omit_tail_delimiter" flag.

  Although technically "behavior flags" are independent from "style",
  we see sense deriving behavior flags from style.

  For example for one-liner we don't want tail delimiter.
  But want it in multi-liner.

  Arguments processing:

    * If caller passed nothing, we'll use some default style.
    * We'll set behavior flags from style.
    * If caller passed some behavior flags, we'll apply them.
]]

local configure_style
do
  local KnownStyles =
    {
      [1] = 'minimal',
      [2] = 'readable_short',
      [3] = 'readable_long',
    }

  local default_style = KnownStyles[3]

  -- Map of style name to integer
  local Styles
  do
    local invert_table = request('!.table.invert')
    Styles = invert_table(KnownStyles)
  end

  local KnownBehaviors =
    {
      [1] = 'use_compact_indices',
      [2] = 'use_compact_sequences',
      [3] = 'omit_tail_delimiter',
    }

  -- Map of behavior name to integer
  local Behaviors
  do
    local invert_table = request('!.table.invert')
    Behaviors = invert_table(KnownBehaviors)
  end

  local StyleToBehavior =
    {
      [Styles.minimal] =
        {
          [Behaviors.use_compact_indices] = true,
          [Behaviors.use_compact_sequences] = true,
          [Behaviors.omit_tail_delimiter] = true,
        },
      [Styles.readable_short] =
        {
          [Behaviors.use_compact_indices] = true,
          [Behaviors.use_compact_sequences] = true,
          [Behaviors.omit_tail_delimiter] = true,
        },
      [Styles.readable_long] =
        {
          [Behaviors.use_compact_indices] = true,
          [Behaviors.use_compact_sequences] = false,
          [Behaviors.omit_tail_delimiter] = false,
        },
    }

  local Syntels_Map =
    {
      [Styles.minimal] = request('Syntels.minimal'),
      [Styles.readable_short] = request('Syntels.readable_short'),
      [Styles.readable_long] = request('Syntels.readable_long'),
    }

  local Formatters =
    {
      [Styles.readable_long] = request('Formatters.Readable_Long'),
    }

  local empty_func = function() end

  configure_style =
    function(Settings, Output, Options)
      assert_table(Options)

      local style_idx
      do
        local style_str = Options.style or default_style
        style_idx = Styles[style_str]
      end

      if not style_idx then
        error('Unknown style.')
      end

      Settings.Output = Output
      Settings.Syntels = Syntels_Map[style_idx]

      -- Apply behavior flags from style
      do
        local Behavior = StyleToBehavior[style_idx]

        for behavior_idx, flag_value in ipairs(Behavior) do
          Settings[KnownBehaviors[behavior_idx]] = flag_value
        end
      end

      -- Apply directly passed behavior flags
      for behavior_idx, behavior_flag_name in ipairs(KnownBehaviors) do
        if is_boolean(Options[behavior_flag_name]) then
          Settings[behavior_flag_name] = Options[behavior_flag_name]
        end
      end

      -- Assign formatter function
      do
        local Formatter = Formatters[style_idx]
        local notify_func = empty_func
        if Formatter then
          notify_func = Formatter.create()
        end

        Settings.notify = notify_func
      end
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
  2026 # # # # # # # #
  2026-08-20
]]
