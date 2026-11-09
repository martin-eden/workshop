-- Serialize assignment

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node)
    if not me:process_node(node.dest_list) then
      return
    end
    if node.val_list then
      me[2]:add_to_textline(' = ')
      return me:process_block(node.val_list)
    end
    return true
  end

--[[
  2016 #
  2017 # #
]]
