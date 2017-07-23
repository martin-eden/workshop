local extract_number_re =
  {
    'Request for Comments: (%d+)',
    'RFC # (%d+)',
  }

return
  function(block)
    local num_str = block[2]
    local result
    local i = 1
    while extract_number_re[i] do
      result = num_str:match(extract_number_re[i])
      if result then
        break
      end
      i = i + 1
    end

    if not result then
      print(('! can\'t extract RFC number from string "%s"'):format(num_str))
    end

    return result
  end
