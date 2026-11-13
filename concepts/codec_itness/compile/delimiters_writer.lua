-- Data separation/indentation

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  We don't care about items encoding. It's [DataWriter]'s job.

  We do care about whitespaces and types of adjacent items.

  Delimiter depends from types of adjacent items.
  So central idea here is to create matrix ( prev_item cur_item )
  which will store what action to apply.
]]

--[[
  Storage format

    1 [s] -- previous event
    2 [b] -- is on empty line?
    3 [t] -- indent instance
    4 [t] -- output stream
]]

local empty_func = function(me) end

local syntax = request('^.syntax')
local space = syntax.delimiters_space_char
local newline = syntax.delimiters_newline_char

local emit_space
local emit_indent
do
  local emit =
    function(me, str)
      if (str == '') then return end
      me[4]:write(str)
      me[2] = false
    end
  emit_space =
    function(me)
      emit(me, space)
    end
  emit_indent =
    function(me)
      if not me[2] then
        emit(me, newline)
        me[2] = true
      end
      emit(me, me[3]:to_string())
    end
end

--[[
  Decision matrix

  Return delimiting function given previous and current events.
]]
local events_map =
  {
    ['nothing'] =
      {
        ['nothing'] = empty_func,
        ['write_string'] = empty_func,
        ['start_list'] = empty_func,
        ['end_list'] = empty_func,
      },
    ['write_string'] =
      {
        ['nothing'] = empty_func,
        ['write_string'] = emit_space,
        ['start_list'] = emit_indent,
        ['end_list'] = emit_space,
      },
    ['start_list'] =
      {
        ['nothing'] = empty_func,
        ['write_string'] = emit_space,
        ['start_list'] = emit_indent,
        ['end_list'] = empty_func,
      },
    ['end_list'] =
      {
        ['nothing'] = emit_indent,
        ['write_string'] = emit_indent,
        ['start_list'] = emit_indent,
        ['end_list'] = emit_indent,
      },
  }

--[[
  Write delimiters between items

  Delimiter depends of previous and current item types.
]]
local event =
  function(me, cur_event)
    local prev_event = me[1]
    local indent = me[3]
    local is_on_empty_line = me[2]

    if (prev_event ~= 'nothing') then
      is_on_empty_line = false
    end

    if (cur_event == 'end_list') then indent:dec() end

    events_map[prev_event][cur_event](me)

    if (cur_event == 'start_list') then indent:inc() end

    prev_event = cur_event

    me[1] = prev_event
    me[2] = is_on_empty_line
  end

local create
local interface
do
  local indent_chunk = '  '
  local min_indent = 0
  local max_indent = 60
  local indent_class = request('!.concepts.indent')
  local attach_methods = request('!.table.attach_methods')
  create =
    function(output)
      local indent =
        indent_class.create(indent_chunk, min_indent, max_indent)

      local me =
        {
          [1] = 'nothing',
          [2] = true,
          [3] = indent,
          [4] = output,
        }

      attach_methods(me, interface)

      return me
    end
end

interface =
  {
    create = create,
    event = event,
  }

-- Export:
return interface

--[[
  2024 # # # # #
  2025 #
  2026 # # # #
  2026-11-13
]]
