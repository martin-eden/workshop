-- Serialize global function

--[[
  Author: Martin Eden
  Last mod.: 2026-10-25
]]

return
  function(Me, Node)
    local Printer = Me.printer

    Printer:RequestEmptyLine()
    Printer:AddToCurline('function ')
    if not Me:process_node(Node.dotted_name) then
      return
    end
    if Node.colon_name then
      if not Me:process_node(Node.colon_name) then
        return
      end
    end
    if not Me:process_node(Node.params) then
      return
    end

    Printer:RequestCleanLine()
    if not Me:process_block_multiline(nil, Node.body, 'end') then
      return
    end

    Printer:RequestEmptyLine()
    return true
  end

--[[
  2016 #
  2017 # # # #
]]
