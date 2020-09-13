--[[
  Return true if given integer can be converted to BCD byte.
  Else return false and string with error in second result.
]]

return
  function(n)
    assert_integer(n)
    local result, err_msg = true
    if (n < 0) then
      result = false
      err_msg = ("Can't represent negative number %d in BCD."):format(n)
    elseif (n >= 100) then
      result = false
      err_msg = ("Number %d >= 100. Can't represent in BCD."):format(n)
    end
    return result, err_msg
  end
