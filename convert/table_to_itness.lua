-- Convert Lua table to Itness format

--[[
  Author: Martin Eden
  Last mod.: 2026-06-15
]]

--[[
  Input structure

  Map. Typical Lua table with named keys.


  Restrictions

  Key names must be strings or integers.
  Values must be strings or integers or booleans or tables.

  ( It's injective transformation written for practical needs

    Integers are mapped to strings. So it's impossible to
    figure out original type of value. F.e. "1" was '1' or 1 ?
  )


  Example:

    { a = 'A', b = { bb = 0 } }
                     ->
    { { 'a', 'A' }, { 'b', { 'bb', '0' } } }
]]

-- Imports:
local ordered_pass = request('!.table.ordered_pass')
local add_to_list = request('!.concepts.list.add_item')

local data_tree_to_itness
data_tree_to_itness =
  function(DataTree)
    local ResultIs = { }

    for key, val in ordered_pass(DataTree) do
      if
        not (
          (is_string(key) or is_integer(key)) and
          (is_string(val) or is_integer(val) or is_boolean(val) or is_table(val))
        )
      then
        goto next
      end

      local NodeIs = { }

      NodeIs[1] = tostring(key)

      if is_table(val) then
        NodeIs[2] = data_tree_to_itness(val)
      else
        NodeIs[2] = tostring(val)
      end

      add_to_list(ResultIs, NodeIs)

      :: next ::
    end

    return ResultIs
  end

-- Export:
return data_tree_to_itness

--[[
  2026-05-05
  2026-06-15
]]
