-- File stream interface

-- Last mod.: 2024-11-11

local force_merge = request('!.table.merge_and_patch')
local result = new(request('^.interface'))
local original_init = result.init

return
  force_merge(
    result,
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
  )

--[[
  2017-05
  2017-08
  2018-08
]]
