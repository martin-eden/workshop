-- Program to return VM bytecode listing

--[[
  Author: Martin Eden
  Last mod.: 2026-11-28
]]

--[[
  Input

    [t] -- arguments
      1 [s] -- name of Lua source file
    [t] -- output stream

  Output

    Bytecode listing in Itness (strings tree) format
]]

local file_to_str = request('!.convert.file_to_str')
local get_bytecode =
  request('!.concepts.lua_bytecode_decompiler.bytecode_from_source')
local get_listing =
  request('!.concepts.lua_bytecode_decompiler.listing_from_bytecode')
local itness_to_stream = request('!.concepts.codec_itness.compile')

-- Export:
return
  function(args, output)
    itness_to_stream(
      get_listing(get_bytecode(file_to_str(args[1]))),
      output
    )
  end

--[[
  2026-09-01
]]
