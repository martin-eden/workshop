return
  function(self, node)
    if not is_table(node) then
      --[[
        Non-table argument given. Typical case is calls from
        process_list() with sequence (<name>, ",", <name> ...).
        Ignore non-table arguments.
      ]]
      return
    end

    local result

    local handler = self.handlers[node.type]
    if handler then
      result = handler(self, node)
      if not result.type then
        result.type = node.type
      end
    else
      result = {type = node.type}
      local result_value
      for i, el in ipairs(node) do
        if is_string(el) then
          if not result_value then
            result_value = el
          end
        elseif is_table(el) then
          table.insert(result, self:process_node(el))
        end
      end
      if (#node > 1) then
        result_value = nil
      end
      result.value = result_value
    end

    return result
  end
