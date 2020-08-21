return
  function(line_iterator)
    local result = {}

    while true do
      line = line_iterator:get_next_line()
      if not line or (line ~= '') then
        break
      end
    end

    if line then
      result[#result + 1] = line

      while true do
        line = line_iterator:get_next_line()
        if not line or (line == '') then
          break
        end
        result[#result + 1] = line
      end
    end

    return result
  end
