local safe_open = request('!.file.safe_open')

return
  function(f_out_name, compile_result)
    assert_string(compile_result)
    local f_out = safe_open(f_out_name, 'w')
    f_out:write(compile_result)
    f_out:close()
  end
