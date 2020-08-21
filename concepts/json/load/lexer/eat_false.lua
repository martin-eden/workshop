return
  function(s, s_pos)
    if (s:sub(s_pos, s_pos + #'false' - 1) == 'false') then
      return 'boolean', s_pos + #'false'
    end
  end
