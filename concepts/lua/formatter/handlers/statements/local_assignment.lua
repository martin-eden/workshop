-- Serialize "local" assignment

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node)
    local printer = me[2]
    printer:add_to_curline('local ')
    if not me:process_block(node.name_list) then
      return
    end
    if node.val_list then
      printer:add_to_textline(' = ')
      return me:process_block(node.val_list)
    end
    return true
  end

--[[
  2016 #
  2017 # #
]]
