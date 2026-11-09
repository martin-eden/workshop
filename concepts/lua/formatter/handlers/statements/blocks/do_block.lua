-- Serialize "do-end" block

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node)
    me[2]:request_clean_line()
    return me:process_block_multiline('do', node[1], 'end')
  end

--[[
  2016 #
  2017 # #
]]
