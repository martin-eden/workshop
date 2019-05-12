return
  function(result, err_msg, err_code)
    if not result then
      err_msg = ('[%d] %s.'):format(err_code, err_msg)
      error(err_msg)
    end
    return result
  end
