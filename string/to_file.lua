-- Save string to file

--[[
  Author: Martin Eden
  Last mod.: 2026-04-27
]]

-- Imports:
local normalize_file_name = request('!.file_system.file.normalize_name')
local create_file_with_contents = request('!.file_system.file.create')

-- Save string to file with given name
local save_str_to_file =
  function(str, file_name)
    create_file_with_contents(normalize_file_name(file_name), str)
  end

-- Export:
return save_str_to_file

--[[
  2018
  2024
  2026-04-27
]]
