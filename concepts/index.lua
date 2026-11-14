-- Index class

--[[
  Author: Martin Eden
  Last mod.: 2026-11-14
]]

--[[
  Data format

    1 [t] -- dimensions. List of natural numbers
]]

--[[
  Receives list of dimensions.

  Exports function to map coordinate to 1-d point.

  Coordinates must be 1-based.
]]

local get_dim =
  function(me, dim_index)
    return me[dim_index]
  end

local get_index =
  function(me, coords)
    local dims = me

    local index = 1
    local stride = 1
    for dims_i = 1, #dims do
      index = index + (coords[dims_i] - 1) * stride
      stride = stride * dims[dims_i]
    end

    return index
  end

local interface
local create
do
  local check_dims
  do
    local is_natural = request('!.number.is_natural')
    check_dims =
      function(dims)
        assert_table(dims)
        for _, dim in ipairs(dims) do
          assert(is_natural(dim))
        end
      end
  end
  local attach_methods = request('!.table.attach_methods')
  create =
    function(dims)
      check_dims(dims)
      local me = new(dims)
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    get_dim = get_dim,
    get_index = get_index,
  }

-- Export:
return interface

--[[
  2026 # #
]]
