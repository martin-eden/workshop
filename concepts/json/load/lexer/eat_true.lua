return
  function(s, s_pos)
    if (s:sub(s_pos, s_pos + #'true' - 1) == 'true') then
      return 'boolean', s_pos + #'true'
    end
  end
