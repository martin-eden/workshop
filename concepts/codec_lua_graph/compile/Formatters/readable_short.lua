-- Tree formatter: readable for short (under one line) data

--[[
  Author: Martin Eden
  Last mod.: 2026-06-20
]]

-- Imports:
local patch_table = request('!.table.patch')

local install =
  function(Config)
    patch_table(
      Config,
      {
        use_compact_indices = true,
        use_compact_sequences = true,
        omit_tail_delimiter = true,

        empty_table_str = '{ }',
        opening_table_str = '{ ',
        closing_table_str = ' }',
        delimiter_str = ', ',
        equal_str = ' = ',
      }
    )
  end

-- Export:
return install

--[[
  2026-06-19
  2026-06-20
]]
