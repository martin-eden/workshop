-- Style formatting for Lua tokens

--[[
  Author: Martin Eden
  Last mod.: 2026-08-27
]]

--[=[
  There is syntactic clash between "long quote" and "table index":

    ['abc'] -- OK, [[[abc]]] -- not OK

  This module handles this.
]=]

--[[
  It's implemented as wrapper over output stream

  We expect that chunks to write are Lua tokens and
  write whitespaces before them according to our judgement.
]]

--[[
  Instance storage format

  Table with named values:

    [t] Output -- output stream
    [s] prev_token -- previous token
    [s] style -- formatting style name
    [t] Indent -- line indent instance
]]

local empty = ''
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
        if (prev_token == empty) then
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

  local space
  local newline
  do
    local AsciiChars = request('!.concepts.Ascii.Chars')
    space = AsciiChars.space
    newline = AsciiChars.newline
  end

  write =
    function(Me, next_token)
      local Output = Me.Output
      local prev_token = Me.prev_token
      local style = Me.style
      local Indent = Me.Indent

      -- Write whitespaces
      do
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
              (prev_token == syntel_item_separator)
            action_emit_newline =
              action_emit_newline or
              (prev_token == syntel_statement_separator)
          elseif (style == 'readable_long') then
            if (next_token == syntel_start_table) then
              Indent:Inc()
            elseif (next_token == syntel_end_table) then
              Indent:Dec()
            end
            local is_empty_table =
              (prev_token == syntel_start_table) and
              (next_token == syntel_end_table)
            action_emit_space =
              action_emit_space or
              (prev_token == syntel_assign) or
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
              (prev_token == syntel_item_separator) or
              (prev_token == syntel_statement_separator)
          end
        end

        if action_emit_space then
          Output:Write(space)
        end
        if action_emit_newline then
          Output:Write(newline)
          local indent_str = Indent:ToString()
          if (indent_str ~= empty) then
            Output:Write(indent_str)
          end
        end
      end

      -- Write token
      Output:Write(next_token)

      Me.prev_token = next_token
    end
end

local Interface
do
  local create
  do
    local IndentClass = request('!.concepts.Indent')
    local attach_methods = request('!.table.attach_methods')

    create =
      function(BaseOutputStream, style)
        assert_table(BaseOutputStream)
        assert_string(style)

        local Core =
          {
            Output = BaseOutputStream,
            prev_token = empty,
            style = style,
            Indent = IndentClass.create(),
          }

        attach_methods(Core, Interface)

        return Core
      end
  end

  Interface =
    {
      create = create,
      Write = write,
    }
end

-- Export:
return Interface

--[[
  2026-08-26
  2026-08-27
]]
