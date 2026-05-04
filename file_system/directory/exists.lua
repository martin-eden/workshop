-- Check for directory presence

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local normalize_name = request('^.file.normalize_name')

local is_directory =
  function(dir_name)
    --[[
      Directory is opened as file

      But when we reading from it io.read() returns error.
    ]]

    assert_string(dir_name)

    dir_name = normalize_name(dir_name)

    local file = io.open(dir_name, 'rb')

    -- No such thing with this name
    if is_nil(file) then
      return false
    end

    -- Trying to read
    local _, err_str, err_num = file:read(1)

    local is_dir =
      (err_num == 21) and (err_str == 'Is a directory')

    file:close()

    return is_dir
  end

-- Export:
return is_directory

--[[
  2024
  2026-05-04
]]
