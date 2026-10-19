-- .mmd tokens writer with formatting

--[[
  Author: Martin Eden
  Last mod.: 2026-09-15
]]

--[[
  Internal state

    1 [t] -- output stream instance
    2 [i] -- current line length
    3 [s] -- previous token
    4 [t] -- indent instance
]]

local Spaces = request('Spaces')
local Syntels = request('Syntels')

local end_line
local empty_line
do
  local line_separator = Spaces.newline
  end_line =
    function(Me)
      if (Me[2] == 0) then return end

      Me[1]:Write(line_separator)
      Me[2] = 0
      Me[3] = ''
    end

  empty_line =
    function(Me)
      end_line(Me)
      Me[1]:Write(line_separator)
    end
end

local write
do
  local item_separator = Spaces.space
  local sep_len = #item_separator
  local is_alnum = request('!.concepts.Ascii.is_alnum')
  local str_sub = string.sub
  local str_byte = string.byte
  local ends_with = request('!.string.ends_with')
  local wrapping_len = 53
  local arrow = Syntels.arrow
  local end_statement = Syntels.end_statement
  local kw_flowchart = Syntels.kw_flowchart
  write =
    function(Me, token)
      local OutputStream = Me[1]
      local line_len = Me[2]
      local prev_token = Me[3]
      local Indent = Me[4]

      if (line_len == 0) then
        OutputStream:Write(Indent:ToString())
      end

      if (line_len > wrapping_len) and (token == arrow) then
        --[[
          Wrap lines before "-->"

            a --> b --> c

          goes to

            a --> b
            b --> c
        ]]
        end_line(Me)
        OutputStream:Write(Indent:ToString())
        OutputStream:Write(prev_token)
      end

      do
        local write_sep = false

        if (prev_token ~= '') then
          local prev_char_code = str_byte(str_sub(prev_token, -1, -1))
          local next_char_code = str_byte(str_sub(token, 1, 1))
          write_sep =
            -- Separation is strictly needed say between "flowchart" and "TD"
            (is_alnum(prev_char_code) and is_alnum(next_char_code)) or
            -- Add separation around "-->"
            ((prev_token == arrow) or (token == arrow))
        end

        if write_sep then
          OutputStream:Write(item_separator)
          Me[2] = Me[2] + sep_len
        end
      end

      OutputStream:Write(token)

      -- We can only increase indent at this level as format is not braced
      if (token == kw_flowchart) then
        Indent:Inc()
      end

      Me[2] = Me[2] + #token
      Me[3] = token
    end
end

local Interface
do
  local create
  do
    local IndentClass = request('!.concepts.Indent')
    local indent_chunk = '  '
    local attach_methods = request('!.table.attach_methods')

    create =
      function(BaseOutputStream)
        assert_table(BaseOutputStream)

        local Indent = IndentClass.create()
        Indent:SetIndentChunk(indent_chunk)

        local Core =
          {
            [1] = BaseOutputStream,
            [2] = 0,
            [3] = '',
            [4] = Indent,
          }

        attach_methods(Core, Interface)

        return Core
      end
  end

  Interface =
    {
      create = create,
      EndLine = end_line,
      EmptyLine = empty_line,
      Write = write,
    }
end

-- Export:
return Interface

--[[
  2026-09-15
]]
