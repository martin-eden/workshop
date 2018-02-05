return
  function(self, node)
    if not is_table(node) then
      return -- todo: should investigate this case
    end

    local result

    if not node.type then
      error('Given node has no .type')
    end

    local handler = self.handlers[node.type]
    if handler then
      result = handler(self, node)
      if not result.type then
        result.type = node.type
      end
    else
      result =
        {
          type = node.type,
          value = node.value,
        }
    end

    return result
  end
