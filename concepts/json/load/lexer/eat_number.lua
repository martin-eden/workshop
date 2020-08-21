--[[
  Numbers in JSON must start with digit. If first digit is "0" then
  it must be sole digit in integer part. Optional "-" sign allowed.
]]

return
  function(s, s_pos)
    local start_pos, finish_pos
    if (s:sub(s_pos, s_pos) == '-') then
      s_pos = s_pos + 1
    end
    if (s:sub(s_pos, s_pos) == '0') then
      s_pos = s_pos + 1
    else
      start_pos, finish_pos = s:find('^[%d]+', s_pos)
      if not finish_pos then
        return
      end
      s_pos = finish_pos + 1
    end
    start_pos, finish_pos = s:find('^%.[%d]+', s_pos)
    if finish_pos then
      s_pos = finish_pos + 1
    end
    start_pos, finish_pos = s:find('^[eE][%+%-]?[%d]+', s_pos)
    if finish_pos then
      s_pos = finish_pos + 1
    end
    return 'number', s_pos
  end
