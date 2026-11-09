-- Serialize function params (names/vararg list inside "()")

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local oneline_delimiter = ', '

local oneliner =
  function(me, node)
    local printer = me[2]
    printer:add_to_curline('(')
    if not me:process_list(node, oneline_delimiter) then
      return
    end
    printer:add_to_curline(')')
    return true
  end

local multiline_delimiter =
  function(me)
    local printer = me[2]
    printer:add_to_textline(',')
    printer:request_clean_line()
  end

local multiline_block_processor =
  function(me, node)
    return me:process_list_variative(node, oneline_delimiter, multiline_delimiter)
  end

local multiliner =
  function(me, node)
    local printer = me[2]
    me[2]:add_to_curline('(')
    me[2]:request_clean_line()
    if not me:process_block(node, multiline_block_processor) then
      return
    end
    me[2]:request_clean_line()
    me[2]:add_to_curline(')')
    return true
  end

return
  function(me, node)
    if (#node == 0) then
      me[2]:add_to_curline('()')
      return true
    else
      return me:variate(node, oneliner, multiliner)
    end
  end

--[[
  2016 #
  2017 #
]]
