-- [LuaRocks] Create rockspec text and save it to file

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local get_rockspec = request('get_rockspec')
local save_to_file = request('!.convert.file_from_str')

local save_rockspec =
  function(Config)
    save_to_file(Config.rockspec_name, get_rockspec(Config))
  end

-- Export:
return save_rockspec

--[[
  2018 # #
  2026-05-05
]]
