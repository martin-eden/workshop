-- Function to use for ordered table traversal instead of pairs()

--[[
  Author: Martin Eden
  Last mod.: 2026-05-23
]]

-- Imports:
local get_key_vals = request('get_key_vals')
local compare_keys = request('ordered_pass.compare_keys')

-- Sort <t> and return iterator function to pass that sorted <t>
local ordered_pass =
  function(t, comparator)
    assert_table(t)
    comparator = comparator or compare_keys
    assert_function(comparator)

    local key_vals = get_key_vals(t)
    table.sort(key_vals, comparator)

    local i = 0
    local sorted_next =
      function()
        i = i + 1
        if key_vals[i] then
          return key_vals[i].key, key_vals[i].value
        end
      end

    return sorted_next, t
  end

-- Export:
return ordered_pass

--[[
  2016-09 # # #
]]
