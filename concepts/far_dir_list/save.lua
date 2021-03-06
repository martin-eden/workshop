local string_adder = request('^.^.mechs.string_adders.any')
local sorted_pairs = request('^.^.table.ordered_pass')

local path = {}

local write_path =
  function(deep)
    string_adder:add([[\]])
    string_adder:add(table.concat(path, [[\]], 1, deep - 1))
    string_adder:add('\x0a')
  end

local visit
visit =
  function(node, deep)
    write_path(deep)
    if is_table(node) then
      for k, v in sorted_pairs(node) do
        local key_str = tostring(k)
        if key_str then
          path[deep] = key_str
          visit(v, deep + 1)
        end
      end
    end
  end

return
  function(struct)
    string_adder:init()
    visit(struct, 1)
    return string_adder:get_result()
  end
