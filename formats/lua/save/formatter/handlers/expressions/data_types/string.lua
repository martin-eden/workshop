local quote_oneline = request('!.formats.lua.save.quote_string')

local oneliner =
  function(self, node)
    local s = quote_oneline(node.value)

    --[=[
       Quite ugly handling indexing [[[s]]] case: convert to [ [[s]]].

       Pasted from [lua_table.save.install_node_handlers.minimal.
       Should remove this doubling.
    ]=]
    if not self.printer:on_clean_line() then
      local text_line = self.printer.line_with_text:get_line()
      if
        (text_line:sub(-1) == '[') and
        (s:sub(1, 1) == '[')
      then
        self.printer:add_curline(' ')
      end
    end

    self.printer:add_curline(s)
    return true
  end

local has_control_chars = request('!.string.content_attributes').has_control_chars
local quote_multiline = request('!.formats.lua.save.quote_string.intact')

local multiliner =
  function(self, node)
    local s = node.value
    if has_control_chars(s) then
      s = quote_multiline(s)
    else
      s = quote_oneline(s)
    end

    self.printer:add_curline(s)
    return true
  end

return
  function(self, node)
    return self:variate(node, oneliner, multiliner)
  end
