-- Return strings tree with bytecode instructions for bytecode string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Basically it's wrapper over text output from "luac" program.
]]

local get_listing = request('listing_from_bytecode.get_listing')
local input_string_stream = request('!.concepts.streams.input.string')
local input_lines_stream = request('!.concepts.streams.input.lines')
local parse_listing = request('listing_from_bytecode.parse_listing')

return
  function(bytecode_str)
    local listing_str = get_listing(bytecode_str)

    local input_lines
    do
      local input = input_string_stream.create(listing_str)
      input_lines = input_lines_stream.create(input)
    end

    return parse_listing(input_lines)
  end

--[[
  2026 # # #
]]
