local quote_string =
  function(s)
    assert_string(s)
    local result = s
    result = result:gsub([[\]], [[\\]])
    -- both "\/" and "/" means "/". We're not quoting "/".
    result = result:gsub('"', [[\"]])
    result = result:gsub('\x08', [[\b]])
    result = result:gsub('\x0c', [[\f]])
    result = result:gsub('\x0a', [[\n]])
    result = result:gsub('\x0d', [[\r]])
    result = result:gsub('\x09', [[\t]])
    --UTF-16 encoding will be here:
    --[[ I don't understand which characters has to be hex-converted.
    So leaving them as is till problems arise.]]
    result = '"' .. result .. '"'
    return result
  end

return quote_string
