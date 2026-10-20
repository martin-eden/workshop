-- Style formatting for Lua tokens

--[[
  Author: Martin Eden
  Last mod.: 2026-10-20
]]

--[[
  Contract

  * You must pass us Lua tokens
  * We will write passed token
  * We may write whitespaces around it
]]

--[[
  Storage format

    1 [s] formatting style name
    2 [s] previous token
    3 [t] padding printer instance
]]

--[=[
  There is syntactic clash between "long quote" and "table index":

    ['abc'] -- OK, [[[abc]]] -- not OK

  This module handles this.
]=]

--[[
  Original idea was to make interface same as for output stream

  So just Write() method.

  Small caveat is that you have to pass to Write() strings that
  are tokens: no spaces. That was natural.

  Problem arouse with indentation. We want to indent key-values as

    a =
      { },

  and just values (implicit key) as

    { },

  So indentation increases for "value" part only for key-value case.

  This can't be naturally coded. So we're exposing indentation methods.
  And thinking about abandoning that "jsut like output stream" idea.
]]

local inc_indent =
  function(Me)
    Me[3]:IncIndent()
  end

local dec_indent =
  function(Me)
    Me[3]:DecIndent()
  end

local Syntels = request('Syntels')

local write
do
  local is_syntax_clash
  do
    local syntel_start_index = Syntels.start_index
    local starts_with = request('!.string.starts_with')
    local str_sub = string.sub
    local str_byte = string.byte
    local is_alnum = request('!.concepts.Ascii.is_alnum')

    is_syntax_clash =
      function(prev_token, next_token)
        if (prev_token == '') then
          return false
        end

        -- Syntax clash for "t={[[[a]]]=1}" (means "t={a=1}")
        if
          (prev_token == syntel_start_index) and
          starts_with(next_token, syntel_start_index)
        then
          return true
        end

        -- Syntax clash for "thenend" (means "then end")
        do
          local prev_char_code = str_byte(str_sub(prev_token, -1, -1))
          local next_char_code = str_byte(str_sub(next_token, 1, 1))

          if is_alnum(prev_char_code) and is_alnum(next_char_code) then
            return true
          end
        end

        return false
      end
  end

  local syntel_start_table = Syntels.start_table
  local syntel_end_table = Syntels.end_table
  local syntel_assign = Syntels.assign
  local syntel_item_separator = Syntels.item_separator
  local syntel_statement_separator = Syntels.statement_separator
  local syntel_return = Syntels.kw_return

  local space
  local newline
  do
    local AsciiChars = request('!.concepts.Ascii.Chars')
    space = AsciiChars.space
    newline = AsciiChars.newline
  end

  write =
    function(Me, next_token)
      local style = Me[1]
      local prev_token = Me[2]
      local Printer = Me[3]

      -- Write whitespaces
      do
        local action_inc_indent = false
        local action_dec_indent = false
        local action_emit_space = false
        local action_emit_newline = false

        do
          action_emit_space =
            action_emit_space or
            is_syntax_clash(prev_token, next_token)

          if (style == 'readable_short') then
            action_emit_space =
              action_emit_space or
              (prev_token == syntel_start_table) or
              (next_token == syntel_end_table) or
              (prev_token == syntel_assign) or
              (next_token == syntel_assign) or
              (prev_token == syntel_item_separator) or
              (prev_token == syntel_return)
            action_emit_newline =
              (prev_token == syntel_statement_separator)
          elseif (style == 'readable_long') then
            action_inc_indent = (prev_token == syntel_start_table)
            action_dec_indent = (next_token == syntel_end_table)
            local is_empty_table =
              (prev_token == syntel_start_table) and
              (next_token == syntel_end_table)
            action_emit_space =
              action_emit_space or
              (
                (prev_token == syntel_assign) and
                (next_token ~= syntel_start_table)
              ) or
              (next_token == syntel_assign) or
              is_empty_table
            action_emit_newline =
              action_emit_newline or
              (
                (prev_token == syntel_start_table) and
                not is_empty_table
              ) or
              (
                (next_token == syntel_end_table) and
                not is_empty_table
              ) or
              (
                (next_token == syntel_start_table) and
                not is_empty_table
              ) or
              (prev_token == syntel_item_separator) or
              (prev_token == syntel_statement_separator)
          end
        end

        if action_inc_indent then
          inc_indent(Me)
        end
        if action_dec_indent then
          dec_indent(Me)
        end
        if action_emit_space then
          Printer:Write(space)
        end
        if action_emit_newline then
          Printer:Newline()
        end
      end

      -- Write token
      Printer:Write(next_token)

      Me[2] = next_token
    end
end

local Interface
do
  local create
  do
    local PaddingPrinter = request('!.concepts.PaddingPrinter')
    local attach_methods = request('!.table.attach_methods')

    create =
      function(BaseOutputStream, style)
        assert_table(BaseOutputStream)
        assert_string(style)

        local Me =
          {
            style,
            '',
            PaddingPrinter.create(BaseOutputStream),
          }
        attach_methods(Me, Interface)

        return Me
      end
  end

  Interface =
    {
      create = create,
      Write = write,
      IncIndent = inc_indent,
      DecIndent = dec_indent,
    }
end

-- Export:
return Interface

--[[
  2026 # # # #
  2026-10-20
]]
