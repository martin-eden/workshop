-- [Luarocks] Create wrappers texts and save them to files

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local get_wrappers = request('get_wrappers')
local save_to_file = request('!.string.save_to_file')

local save_wrappers =
  function(Config)
    assert_table(Config.commands)

    local Wrappers = get_wrappers(Config)

    for idx, Rec in ipairs(Config.commands) do
      save_to_file(Rec.wrapper, Wrappers[idx])
    end
  end

-- Export:
return save_wrappers

--[[
  2018
  2026-05-05
]]
