return
  function(raw_bytes)
    assert_string(raw_bytes)

    local result =
      raw_bytes:gsub(
        '.',
        function(s)
          return ('%02X '):format(s:byte())
        end
      )
    -- Remove tail space:
    result = result:sub(1, -2)

    return result
  end
