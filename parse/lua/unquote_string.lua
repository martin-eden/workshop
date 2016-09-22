local unquote_linear =
  function(s)
    s = s:gsub([[\a]], '\a')
    s = s:gsub([[\b]], '\b')
    s = s:gsub([[\f]], '\f')
    s = s:gsub([[\n]], '\n')
    s = s:gsub([[\r]], '\r')
    s = s:gsub([[\t]], '\t')
    s = s:gsub([[\v]], '\v')

    s = s:gsub([[\"]], '\"')
    s = s:gsub([[\']], '\'')
    s = s:gsub([[\]] .. '\n', '\n')

    --[[
    x hex_dig^2
    z space_char^N
    dec_dig^(1..3)
    u { hex_dig^N }
    ]]

    s = s:gsub([[\\]], [[\]])
    return s
  end

local long_quote_start = '^%[=*%['
local long_quote_finish = '%]=*%]$'
local get_chunk =
  function(s)
    local start_chunk = s:match(long_quote_start)
    local finish_chunk = s:match(long_quote_finish)
    local result
    if start_chunk and (#start_chunk == #finish_chunk) then
      result = chunk
    end
    return result
  end

return
  function(s)
    assert_string(s)

    local not_quoted_msg = ('String (%s) is not quoted.'):format(s)
    assert(#s >= 2, not_quoted_msg)

    local result
    local border_chars = s:sub(1, 1) .. s:sub(-1, -1)

    if (border_chars == "''") then
      result = s:sub(2, -2)
      result = unquote_linear(result)
    elseif (border_chars == '""') then
      result = s:sub(2, -2)
      result = unquote_linear(result)
    elseif (border_chars == '[]') then
      local quote_len = get_chunk(s)
      if not quote_len then
        error(('String "%s" has bad long quotes?'):format(s), 2)
      end
      result = s:sub(quote_len + 1, -quote_len - 1)
    else
      error(not_quoted_msg, 2)
    end

    return result
  end
