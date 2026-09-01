-- Program to return VM bytecode listing

--[[
  Author: Martin Eden
  Last mod.: 2026-09-01
]]

--[[
  Input

    [s] -- name of Lua source file

  Output

    [s] -- bytecode listing in Itness (strings tree) format
]]

local file_to_str = request('!.convert.file_to_str')
local get_bytecode =
  request('!.concepts.lua_bytecode_decompiler.bytecode_from_source')
local get_listing =
  request('!.concepts.lua_bytecode_decompiler.listing_from_bytecode')
local StdoutStream = request('!.concepts.StreamIo.Output.Pipe')
local itness_to_stream = request('!.concepts.codec_itness.compile')

-- Export:
return
  function(source_file_name)
    itness_to_stream(
      get_listing(get_bytecode(file_to_str(source_file_name))),
      StdoutStream
    )
  end

--[[
  2026-09-01
]]
