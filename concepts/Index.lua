-- Index class

--[[
  Author: Martin Eden
  Last mod.: 2026-09-24
]]

--[[
  Data format

    1 [t] -- dimensions. List of natural numbers
]]

-- Coordinates must be 1-based

local Interface

local create
do
  local check_dims
  do
    local is_natural = request('!.number.is_natural')

    check_dims =
      function(Dims)
        assert_table(Dims)
        for _, dim in ipairs(Dims) do
          assert(is_natural(dim))
        end
      end
  end

  local attach_methods = request('!.table.attach_methods')

  create =
    function(Dims)
      check_dims(Dims)

      local Core = new(Dims)
      attach_methods(Core, Interface)

      return Core
    end
end

local get_index =
  function(Core, Coords)
    local Dims = Core

    local index = 0

    local dim_index = 1
    for dims_i = 1, #Dims do
      index = dim_index + Coords[dims_i] - 1
      dim_index = dim_index * Dims[dims_i]
    end

    return index
  end

Interface =
  {
    create = create,
    GetIndex = get_index,
  }

-- Export:
return Interface

--[[
  2026-09-19
]]
