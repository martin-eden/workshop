local unquote = request('!.formats.lua.load.unquote_string')

return
  function(self, node)
    return
      {
        value = unquote(node.value),
      }
  end
