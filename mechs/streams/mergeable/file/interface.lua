-- File stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports"
local BaseInterface = request('^.interface')
local force_merge = request('!.table.merge_and_patch')

local original_init = BaseInterface.init

local Overrides =
  {
    init = request('init'),
    get_position = request('get_position'),
    set_position = request('set_position'),
    read = request('read'),
    write = request('write'),
    get_length = request('get_length'),
    -- extensions:
    match_string = request('match_string'),
    match_regexp = request('match_regexp'),
    -- internal:
    f = nil,
    original_init = original_init,
    assert_no_error = request('assert_no_error'),
  }

local Interface = new(BaseInterface)
force_merge(Interface, Overrides)

-- Export:
return Interface

--[[
  2017-05
  2017-08
  2018-08
  2026-06-17
]]
