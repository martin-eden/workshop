local parse_choice = request('choice_first')

local parse_is_not =
  function(struc, s, s_pos, parse_func)
    local parse_result, new_s_pos = parse_choice(struc, s, s_pos, parse_func)
    parse_result = not parse_result
    return parse_result, new_s_pos
  end

return parse_is_not
