-- Convert Lua table to Itness format

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Input structure

    Map. Typical Lua table with named keys.


  Restrictions

    Key names must be strings or integers.
    Values must be strings or integers or booleans or tables.

    (
      It's injective transformation written for practical needs.
      It's impossible to figure out original type of value.
      F.e. "1" came from '1' or 1 ?
    )


  Example

    { a = 'A', b = { bb = 0 } }
    ->
    { { 'a', 'A' }, { 'b', { 'bb', '0' } } }
]]

local ordered_pass = request('!.table.ordered_pass')
local add_to_list = request('!.concepts.list.add_item')

local data_tree_to_itness
data_tree_to_itness =
  function(data_tree)
    local result = { }

    for key, val in ordered_pass(data_tree) do
      if
        not (
          (is_string(key) or is_integer(key)) and
          (is_string(val) or is_integer(val) or is_boolean(val) or is_table(val))
        )
      then
        goto next
      end

      local node = { }
      node[1] = tostring(key)
      if is_table(val) then
        node[2] = data_tree_to_itness(val)
      else
        node[2] = tostring(val)
      end
      add_to_list(result, node)

      :: next ::
    end

    return result
  end

-- Export:
return data_tree_to_itness

--[[
  2026 # #
]]
