-- Index class

--[[
  Author: Martin Eden
  Last mod.: 2026-09-25
]]

--[[
  Data format

    1 [t] -- dimensions. List of natural numbers
]]

-- Coordinates must be 1-based

local get_dim =
  function(Me, dim_index)
    return Me[dim_index]
  end

local get_index =
  function(Me, Coords)
    local Dims = Me

    local index = 1
    local stride = 1
    for dims_i = 1, #Dims do
      index = index + (Coords[dims_i] - 1) * stride
      stride = stride * Dims[dims_i]
    end

    return index
  end

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

Interface =
  {
    create = create,
    GetDim = get_dim,
    GetIndex = get_index,
  }

-- Export:
return Interface

--[[
  2026-09-19
  2026-09-25
]]
