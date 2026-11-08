-- Serialize to JSON via callbacks

--[[
  Author: Martin Eden
  Last mod.: 2026-11-08
]]

local prepare = request('prepare')
local verify = request('verify')
local compile = request('!.mechs.generic_saver')

local default_serializer = request('generic_compiler.readable.interface')

return
  function(Data, Options)
    Options = Options or { }
    local Serializer = Options[1] or default_serializer
    Serializer:init()

    prepare(Data)
    verify(Data)
    return compile(Data, Serializer:create_stateless_handler())
  end

--[[
  2017 #
  2026-11-08
]]
