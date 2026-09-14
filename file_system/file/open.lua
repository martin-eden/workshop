-- Open file and return handle or throw an error

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

--[[
  Contract is that this function returns file handle or explodes

  No pesky ( nil error_msg ) from stock io.open().
]]

local normalize_name = request('!.concepts.path_name.normalize')
local default_mode = 'rb'
local io_open = io.open

-- Export:
return
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

--[[
  2016 #
  2017 #
  2026 #
]]
