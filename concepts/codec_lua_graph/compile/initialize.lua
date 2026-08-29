-- Prepare serializer instance before serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-08-27
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

local invert_table = request('!.table.invert')

local Styles =
  invert_table(
    {
      [1] = 'minimal',
      [2] = 'readable_short',
      [3] = 'readable_long',
    }
  )

local default_style = 'readable_long'

local TokensOutputStream = request('TokensOutputStream')

local KnownBehaviors =
  {
    [1] = 'use_compact_indices',
    [2] = 'use_compact_sequences',
    [3] = 'omit_tail_delimiter',
  }

local Behaviors = invert_table(KnownBehaviors)

local StyleToBehavior =
  {
    ['minimal'] =
      {
        ['use_compact_indices'] = true,
        ['use_compact_sequences'] = true,
        ['omit_tail_delimiter'] = true,
      },
    ['readable_short'] =
      {
        ['use_compact_indices'] = true,
        ['use_compact_sequences'] = true,
        ['omit_tail_delimiter'] = true,
      },
    ['readable_long'] =
      {
        ['use_compact_indices'] = true,
        ['use_compact_sequences'] = false,
        ['omit_tail_delimiter'] = false,
      },
  }

local empty_func = function() end

-- Export:
return
  function(Settings, Output, Options)
    assert_table(Options)

    local style = Options.style or default_style

    if not Styles[style] then
      error('Unknown style.')
    end

    Settings.Output = TokensOutputStream.create(Output, style)

    -- Apply behavior flags from style
    do
      local Behavior = StyleToBehavior[style]

      for behavior_flag_name, flag_value in pairs(Behavior) do
        Settings[behavior_flag_name] = flag_value
      end
    end

    -- Apply directly passed behavior flags
    for _, behavior_flag_name in ipairs(KnownBehaviors) do
      if is_boolean(Options[behavior_flag_name]) then
        Settings[behavior_flag_name] = Options[behavior_flag_name]
      end
    end
  end

--[[
  2016 #
  2017 #
  2018 #
  2026 # # # # # # # # # # #
]]
