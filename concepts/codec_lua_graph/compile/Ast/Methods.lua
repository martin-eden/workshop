-- Node-creation methods for tree and graph AST

--[[
  Author: Martin Eden
  Last mod.: 2026-08-30
]]

local create_terminal_type_rec
local create_name_rec
local create_table_rec
local create_local_def_rec
local create_assignment_rec
local create_return_rec
do
  local type_name
  local type_table
  local type_local
  local type_assignment
  local type_return
  do
    local TypeNames = request('TypeNames')
    type_name = TypeNames.type_name
    type_table = TypeNames.type_table
    type_local = TypeNames.type_local
    type_assignment = TypeNames.type_assignment
    type_return = TypeNames.type_return
  end

  create_terminal_type_rec =
    function(data)
      return { type(data), data }
    end

  create_name_rec =
    function(name)
      return { type_name, name }
    end

  create_table_rec =
    function()
      return { type_table, { } }
    end

  create_local_def_rec =
    function(name, Value)
      return { type_local, name, Value }
    end

  create_assignment_rec =
    function(dest, index, value)
      return { type_assignment, dest, index, value }
    end

  create_return_rec =
    function(Value)
      return { type_return, Value }
    end
end

-- Export:
return
  {
    create_terminal_type_rec = create_terminal_type_rec,
    create_name_rec = create_name_rec,
    create_table_rec = create_table_rec,
    create_local_def_rec = create_local_def_rec,
    create_assignment_rec = create_assignment_rec,
    create_return_rec = create_return_rec,
  }

--[[
  2026-08-19
]]
