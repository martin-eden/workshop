-- .dot tokens writer with formatting

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

local end_line
local empty_line
do
  local line_separator = spaces.newline
  end_line =
    function(me)
      if (me[2] == 0) then return end

      me[1]:write(line_separator)
      me[2] = 0
      me[3] = ''
    end

  empty_line =
    function(me)
      end_line(me)
      me[1]:write(line_separator)
    end
end

local indent_chunk = '   '

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
  local end_statement = syntels.end_statement
  local start_graph = syntels.start_graph
  local end_graph = syntels.end_graph
  write =
    function(me, token)
      local output = me[1]
      local line_len = me[2]
      local prev_token = me[3]
      local indent = me[4]

      if (token == end_graph) then
        indent:dec()
      end

      if (line_len == 0) then
        output:write(indent:to_string())
      end

      if
        (line_len > wrapping_len) and
        (
          (prev_token == arrow) or
          (prev_token == end_statement)
        )
      then
        -- Wrap lines on "->" or ";"
        end_line(me)
        output:write(indent:to_string())
        output:write(indent_chunk)
      else
        local write_sep = false

        if (prev_token ~= '') then
          local prev_char_code = str_byte(str_sub(prev_token, -1, -1))
          local next_char_code = str_byte(str_sub(token, 1, 1))
          write_sep =
            -- Separation is strictly needed say between "strict" and "digraph"
            (is_alnum(prev_char_code) and is_alnum(next_char_code)) or
            -- Opportunistically add separation to anything except ";" and " "
            (
              (token ~= end_statement) and
              not ends_with(prev_token, item_separator)
            )
        end

        if write_sep then
          output:write(item_separator)
          me[2] = me[2] + sep_len
        end
      end

      output:write(token)

      if (token == start_graph) then
        indent:inc()
      end

      me[2] = me[2] + #token
      me[3] = token
    end
end

local interface
do
  local create
  do
    local indent_class = request('!.concepts.indent')
    local min_indent = 0
    local max_indent = 99
    local attach_methods = request('!.table.attach_methods')
    create =
      function(base_output)
        local indent =
          indent_class.create(indent_chunk, min_indent, max_indent)
        local me = { base_output, 0, '', indent }
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
end

-- Export:
return interface

--[[
  2026 #
  2026-11-28
]]
