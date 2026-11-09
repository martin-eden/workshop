-- JSON serializer with structural indentations

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local interface
do
  do
    local base_interface = request('^.minimal.interface')
    interface = new(base_interface)
  end

  local init
  do
    local indent = request('!.concepts.indent')
    init =
      function(me)
        local indent = indent.create()
        indent:set_indent_chunk(me.indent_chunk)
        me.indent = indent
      end
  end

  local inc_indent =
    function(me)
      me.indent:inc()
    end

  local dec_indent =
    function(me)
      me.indent:dec()
    end

  local get_indent_str =
    function(me)
      return me.indent:to_string()
    end

  local merge_and_patch = request('!.table.merge_and_patch')

  merge_and_patch(
    interface,
    {
      indent_chunk = '  ',
      indent = { },
      dec_indent = dec_indent,
      inc_indent = inc_indent,
      get_indent_str = get_indent_str,

      init = init,
      handlers = request('handlers.interface'),
    }
  )
end

return interface

--[[
  2016
  2017
  2026-08-09
]]
