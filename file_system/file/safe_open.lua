-- Open file and return handle or throw an error

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

--[[
  Contract is that this function returns file handle or explodes

  No pesky ( nil error_msg ) from stock io.open().
]]

-- Imports:
local normalize_name = request('normalize_name')

local default_mode = 'rb'

local open_file =
  function(pathname, mode)
    assert_string(pathname)
    assert(is_nil(mode) or is_string(mode))

    pathname = normalize_name(pathname)
    mode = mode or default_mode

    local file, err_msg = io.open(pathname, mode)

    if not file then
      error(err_msg, 2)
    end

    return file
  end

-- Export:
return open_file

--[[
  2016 #
  2017 #
  2026-05-04
]]
