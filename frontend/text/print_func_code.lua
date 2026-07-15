-- Print Lua function bytecode

--[[
  Author: Martin Eden
  Last mod.: 2026-07-15
]]

-- Prints in TSV format

--[[
  Sample output

  > VARARGPREP  0
  > LOADI       0       17
  > CLOSURE     1       0
  > RETURN      1       2       1k
  > RETURN      2       1       1k
  >
  > CLOSURE     0       0
  > MOVE        1       0
  > TAILCALL    1       1       0
  > RETURN      1       0       0
  > RETURN0
  >
  > CLOSURE     0       0
  > MOVE        1       0
  > CALL        1       1       2
  > ADDI        1       1       1
  > MMBINI      1       1       6       0
  > RETURN1     1
  > RETURN0
  >
  > GETUPVAL    0       0
  > RETURN1     0
  > RETURN0
  >
]]

-- Imports:
local StdoutStream = request('!.concepts.StreamIo.Output.Pipe')
local bytecode_from_function =
  request('!.concepts.lua_bytecode_decompiler.bytecode_from_function')
local listing_from_bytecode =
  request('!.concepts.lua_bytecode_decompiler.listing_from_bytecode')
local itness_to_tsv = request('!.concepts.codec_tsv.compile')

local print_func_code =
  function(func, OutStream)
    OutStream = OutStream or StdoutStream

    local Functions =
      listing_from_bytecode(bytecode_from_function(func))

    local newline = '\010'

    for _, Function in ipairs(Functions) do
      itness_to_tsv(Function, OutStream)
      OutStream:Write(newline)
    end
  end

-- Export:
return print_func_code

--[[
  2026-07-15
]]
