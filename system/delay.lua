--[[
  Delay of given number of seconds (real number).

  Quick-and-dirty implementation cause it's blocking. Right approach
  is use system "sleep" function but it is OS-dependent and so
  requires standalone libraries.
]]

return
  function(delay_secs)
    assert_number(delay_secs)
    assert(delay_secs > 0)
    local init_time = os.clock()
    repeat
      local cur_time = os.clock()
    until (cur_time - init_time >= delay_secs)
  end
