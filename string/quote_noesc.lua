local chunk_name = 'quote_noesc'

local quote_noesc =
  function(s)
    assert_string(s)
    local min_needed_quote = 0 --TODO

    local open_quote = '[' .. ('='):rep(min_needed_quote) .. '['
    local close_quote = ']' .. ('='):rep(min_needed_quote) .. ']'
    return open_quote .. s .. close_quote
  end

tribute(chunk_name, quote_noesc)
