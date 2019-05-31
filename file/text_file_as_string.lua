--[[
  Fucken editors tend to save files in UTF-8 or UTF-16.
  In this case staring bytes are (EF BB BF) for UTF-8,
  (FF FE) or (FE FF) for UTF-16 little- and bin-endian.
  These bytes wrecks any further data parsing.

  This routine just strips UTF-8 sequence if found at start of file.
  UTF-16 sequences is not stripped as characters will be two-byte
  and parsing will fail anyway.
]]

local file_as_string = request('as_string')

local utf8_prefix = '\xef\xbb\xbf'

return
  function(file_name)
    local result = file_as_string(file_name)
    local prefix = utf8_prefix
    if (result:sub(1, #prefix) == prefix) then
      result = result:sub(#prefix + 1)
    end
    return result
  end
