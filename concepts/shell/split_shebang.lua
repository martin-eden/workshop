-- Split shebang line from string

--[[
  Author: Martin Eden
  Last mod.: 2026-07-17
]]

--[[
  Input

    [s] str -- String possibly starting with shebang line

  Output

    1 [?s] -- Shebang line (nil if not present)
    2 [s] -- String without shebang line
]]

--[[
  Split shebang line from string

  ( '#!/bin/bash\ncode' ) -> ( '#!/bin/bash' 'code' )
  ( 'code' ) -> ( nil 'code' )
]]

-- Imports:
local starts_with = request('!.string.starts_with')

local str_find = string.find
local str_sub = string.sub

local shebang_prefix = '#!'
local newline = '\010'

local split_shebang =
  function(str)
    assert_string(str)

    if not starts_with(str, shebang_prefix) then return nil, str end

    local newline_pos = str_find(str, newline)

    if not newline_pos then return str, '' end

    local shebang_str = str_sub(str, 1, newline_pos - 1)
    local rest_str = str_sub(str, newline_pos + 1)

    return shebang_str, rest_str
  end

-- Export:
return split_shebang

--[[
  2026-07-17
]]
