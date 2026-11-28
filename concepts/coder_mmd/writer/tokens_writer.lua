-- .mmd tokens writer with formatting

--[[
  Author: Martin Eden
  Last mod.: 2026-11-28
]]

--[[
  Internal state

    1 [t] -- output stream instance
    2 [i] -- current line length
    3 [s] -- previous token
    4 [t] -- indent instance
]]

local spaces = request('spaces')
local syntels = request('syntels')

local end_line =
  function(me)
    if (me[2] == 0) then return end
    me[1]:write(spaces.newline)
    me[2] = 0
    me[3] = ''
  end

local empty_line =
  function(me)
    end_line(me)
    me[1]:write(spaces.newline)
  end

local write
do
  local item_separator = spaces.space
  local sep_len = #item_separator
  local is_alnum = request('!.concepts.ascii.is_alnum')
  local str_sub = string.sub
  local str_byte = string.byte
  local ends_with = request('!.string.ends_with')
  local wrapping_len = 53
  local arrow = syntels.arrow
  local kw_flowchart = syntels.kw_flowchart
  write =
    function(me, token)
      local output_stream = me[1]
      local line_len = me[2]
      local prev_token = me[3]
      local indent = me[4]

      if (line_len == 0) then
        output_stream:write(indent:to_string())
      end

      if (line_len > wrapping_len) and (token == arrow) then
        --[[
          Wrap lines before "-->"

          "a --> b --> c" goes to "a --> b", "b --> c"
        ]]
        end_line(me)
        output_stream:write(indent:to_string())
        output_stream:write(prev_token)
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
          output_stream:write(item_separator)
          me[2] = me[2] + sep_len
        end
      end

      output_stream:write(token)

      -- We can only increase indent at this level as format is not braced
      if (token == kw_flowchart) then
        indent:inc()
      end

      me[2] = me[2] + #token
      me[3] = token
    end
end

local interface
local create
do
  local indent_class = request('!.concepts.indent')
  local indent_chunk = '  '
  local min_indent = 0
  local max_indent = 99
  local attach_methods = request('!.table.attach_methods')
  create =
    function(output)
      assert_table(output)
      local indent =
        indent_class.create(indent_chunk, min_indent, max_indent)
      local me = { output, 0, '', indent }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    end_line = end_line,
    empty_line = empty_line,
    write = write,
  }

-- Export:
return interface

--[[
  2026-09-15
]]
