return
  function(pattern_str)
    assert_string(pattern_str)
    local regexp_str, prefix_rec, postfix_rec
    regexp_str = pattern_str
    if (pattern_str:sub(1, 1) == '^') then
      prefix_rec =
        {
          type = 'start_of_data',
          value = '^',
        }
      regexp_str = regexp_str:sub(2)
    end
    if
      (pattern_str:sub(-1) == '$') and
      (pattern_str:sub(-2) ~= '%$')
    then
      postfix_rec =
        {
          type = 'end_of_data',
          value = '$',
        }
      regexp_str = regexp_str:sub(1, -2)
    end
    return regexp_str, prefix_rec, postfix_rec
  end
