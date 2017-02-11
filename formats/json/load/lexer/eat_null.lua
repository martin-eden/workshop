return
  function(s, s_pos)
    if (s:sub(s_pos, s_pos + #'null' - 1) == 'null') then
      return 'null', s_pos + #'null'
    end
  end
