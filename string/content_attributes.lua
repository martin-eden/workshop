local has_control_chars =
  function(s)
    return s:find('%c') and true
  end

local has_backslashes =
  function(s)
    return s:find([[%\]]) and true
  end

local has_single_quotes =
  function(s)
    return s:find([[%']]) and true
  end

local has_double_quotes =
  function(s)
    return s:find([[%"]]) and true
  end

local is_nonascii =
  function(s)
    return s:find('[^%w%s_%p]')
  end

local has_newlines =
  function(s)
    return s:find('[\n\r]')
  end

return
  {
    has_control_chars = has_control_chars,
    has_backslashes = has_backslashes,
    has_single_quotes = has_single_quotes,
    has_double_quotes = has_double_quotes,
    is_nonascii = is_nonascii,
    has_newlines = has_newlines,
  }

--[[
  2016-09
  2017-02
  2017-08
  2024-11
]]
