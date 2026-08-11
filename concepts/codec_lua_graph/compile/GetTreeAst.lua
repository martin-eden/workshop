-- Build AST for tree data

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

local create_name_rec =
  function(name)
    return { 'name', name }
  end

local create_table_rec =
  function()
    return { 'table', { } }
  end

local get_tree_ast
do
  local create_terminal_type_rec =
    function(data)
      return { type(data), data }
    end

  local add_to_list = request('!.concepts.list.add_item')

  get_tree_ast =
    function(Data, table_iterator, NamedValues)
      NamedValues = NamedValues or { }

      if NamedValues[Data] then
        return create_name_rec(NamedValues[Data])
      end

      if not is_table(Data) then
        return create_terminal_type_rec(Data)
      end

      local Result = create_table_rec()
      local KeyVals = Result[2]

      for Key, Value in table_iterator(Data) do
        add_to_list(
          KeyVals,
          {
            get_tree_ast(Key, table_iterator, NamedValues),
            get_tree_ast(Value, table_iterator, NamedValues),
          }
        )
      end

      return Result
    end
end

local Interface =
  {
    get_tree_ast = get_tree_ast,

    create_name_rec = create_name_rec,
    create_table_rec = create_table_rec,
  }

-- Export:
return Interface

--[[
  2018 # # #
  2019 #
  2020 #
  2022 #
  2024 #
  2026 # # # #
  2026-08-11
]]
