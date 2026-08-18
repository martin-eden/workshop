-- Build AST for tree data

--[[
  Author: Martin Eden
  Last mod.: 2026-08-20
]]

local get_tree_ast
do
  local create_name_rec
  local create_terminal_type_rec
  local create_table_rec
  do
    local Methods = request('Ast.Methods')
    create_name_rec = Methods.create_name_rec
    create_terminal_type_rec = Methods.create_terminal_type_rec
    create_table_rec = Methods.create_table_rec
  end

  local table_iterator = request('!.table.ordered_pass')
  local add_to_list = request('!.concepts.list.add_item')

  get_tree_ast =
    function(Data, NamedValues)
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
            get_tree_ast(Key, NamedValues),
            get_tree_ast(Value, NamedValues),
          }
        )
      end

      return Result
    end
end

-- Export:
return get_tree_ast

--[[
  2018 # # #
  2019 #
  2020 #
  2022 #
  2024 #
  2026 # # # # # # #
  2026-08-20
]]
