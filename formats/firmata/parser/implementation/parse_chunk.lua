return
  function(stream, parsers, results)
    local orig_pos = stream:get_position()
    local longest_pos = 0
    local best_result
    for _, parser in ipairs(parsers) do
      local record = parser(stream)
      if record then
        local current_pos = stream:get_position()
        if (current_pos > longest_pos) then
          best_result = record
          longest_pos = current_pos
        end
      end
      stream:set_position(orig_pos)
    end
    if best_result then
      table.insert(results, best_result)
      stream:set_position(longest_pos)
      return true
    end
  end
