-- Data separation/indentation

--[[
  Author: Martin Eden
  Last mod.: 2026-05-23
]]

--[[
  We don't care about items encoding. It's [DataWriter]'s job.

  We do care about whitespaces and types of adjacent items.
]]

-- Imports:
local IndentClass = request('!.concepts.Indent')

local Interface =
  {
    -- [Config] Output stream
    Output = { },

    -- [Config] Space character
    space_char = '',

    -- [Config] Newline character
    newline_char = '',

    -- [Main] Initialize state
    Init =
      function(Me)
        Me.Indent = IndentClass.create()
        local spaces_per_indent = 2
        Me.Indent.indent_chunk =
          string.rep(Me.space_char, spaces_per_indent)

        Me.prev_event = 'nothing'

        Me.is_on_empty_line = true
      end,

    -- [Main] Emit event-dependent indentation
    HandleEvent = request('HandleEvent'),

    -- [Internal]:
    Indent = Indent,
    prev_event = '',
    is_on_empty_line = false,
  }

-- Export:
return Interface

--[[
  2024 # #
  2026-05-11
  2026-05-23
]]
