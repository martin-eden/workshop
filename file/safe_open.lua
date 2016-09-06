local safe_open =
  function(file_name, mode)
    assert_string(file_name)
    assert_string(mode)
    local f_object, err_msg = io.open(file_name, mode)
    if not f_object then
      error(err_msg, 2)
    end
    return f_object
  end

return safe_open
