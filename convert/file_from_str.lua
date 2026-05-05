-- Save string to file

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Unlike other functions in "convert/", this function returns nothing.

-- Imports:
local create_file_with_contents = request('!.file_system.file.create')

-- Save string to file with given name
local save_str_to_file =
  function(str, file_name)
    create_file_with_contents(file_name, str)
  end

-- Export:
return save_str_to_file

--[[
  2018
  2024
  2026-04-27
  2026-05-04
]]
