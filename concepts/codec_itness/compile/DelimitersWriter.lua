-- Data separation/indentation

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
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

    1 [s] -- space char
    2 [s] -- newline char
    3 [t] -- indent instance
    4 [s] -- previous event
    5 [b] -- is on empty line?
    6 [t] -- output stream
]]

-- Write string. Update "is on empty line" flag
local emit =
  function(me, str)
    if (str == '') then return end
    me[6]:Write(str)
    me[5] = false
  end

-- Delimiting functions:

local empty_func = function(me) end

local emit_space = function(me) emit(me, me[1]) end

local emit_indent =
  -- Write newline and indentation
  function(me)
    -- Assure that next string will be written on new line
    if not me[5] then
      emit(me, me[2])
      me[5] = true
    end

    emit(me, me[3]:to_string())
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
local handle_event =
  function(me, cur_event)
    local indent = me[3]
    local prev_event = me[4]
    local is_on_empty_line = me[5]

    if (prev_event ~= 'nothing') then
      is_on_empty_line = false
    end

    if (cur_event == 'end_list') then indent:dec() end

    events_map[prev_event][cur_event](me)

    if (cur_event == 'start_list') then indent:inc() end

    prev_event = cur_event

    me[4] = prev_event
    me[5] = is_on_empty_line
  end

local create
local interface
do
  local indent_class = request('!.concepts.indent')
  local spaces_per_indent = 2
  local str_rep = string.rep
  local attach_methods = request('!.table.attach_methods')
  create =
    function(space_char, newline_char, OutputStream)
      local indent = indent_class.create()
      local indent_chunk = str_rep(space_char, spaces_per_indent)
      indent:set_indent_chunk(indent_chunk)

      local me =
        {
          [1] = space_char,
          [2] = newline_char,
          [3] = indent,
          [4] = 'nothing',
          [5] = true,
          [6] = OutputStream,
        }

      attach_methods(me, interface)

      return me
    end
end

interface =
  {
    create = create,
    HandleEvent = handle_event,
  }

-- Export:
return interface

--[[
  2024 # # # # #
  2025 #
  2026 # #
  2026-10-14
]]
