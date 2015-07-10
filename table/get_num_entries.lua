require('#base')

local chunk_name = 'table.get_num_entries'

local get_num_entries =
  function(t)
    local result
    if is_table(t) then
      result = 0
      for k in pairs(t) do
        result = result + 1
      end
    end
    return result
  end

tribute(
  chunk_name,
  get_num_entries
)
