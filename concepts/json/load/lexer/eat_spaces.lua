local space_chars =
  {
    [' '] = true,
    ['\n'] = true,
    ['\r'] = true,
    ['\t'] = true,
  }

return
  function(s, s_pos)
    if space_chars[s:sub(s_pos, s_pos)] then
      repeat
        s_pos = s_pos + 1
      until not space_chars[s:sub(s_pos, s_pos)]
      return 'spaces', s_pos
    end
  end
