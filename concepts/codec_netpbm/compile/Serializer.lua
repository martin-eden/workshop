-- Typed strings serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

-- Imports:
local Syntels = request('^.Syntels')

local newline = Syntels.newline
local data_separator = Syntels.space
local comment_indent = Syntels.space .. Syntels.space
local comment_prefix = Syntels.comment_char .. Syntels.space

local Interface =
  {
    -- Config:
    Output = {},

    -- Main:
    WriteRaw =
      function(Me, raw_str)
        Me.Output:Write(raw_str)

        Me.state = 'init'
      end,

    WriteNewline =
      function(Me)
        Me:WriteRaw(newline)
      end,

    WriteData =
      function(Me, data_any)
        local Output = Me.Output

        if (Me.state == 'wrote_data') then
          Output:Write(data_separator)
        end

        Output:Write(tostring(data_any))

        Me.state = 'wrote_data'
      end,

    WriteComment =
      function(Me, comment_str)
        local Output = Me.Output

        if (Me.state == 'wrote_data') then
          Output:Write(comment_indent)
        end
        Output:Write(comment_prefix)
        Output:Write(comment_str)

        Me:WriteNewline()
      end,

    -- Internals:
    state = 'init',
  }

-- Export:
return Interface

--[[
  2026-06-15
]]
