-- Serialize graph AST

--[[
  Author: Martin Eden
  Last mod.: 2026-08-27
]]

local Syntels = request('Syntels')

local serialize_graph
do
  local type_local
  local type_assignment
  local type_return
  local type_string
  do
    local TypeNames = request('Ast.TypeNames')
    type_local = TypeNames.type_local
    type_assignment = TypeNames.type_assignment
    type_return = TypeNames.type_return
    type_string = TypeNames.type_string
  end

  local serialize_value = request('serialize_tree_ast')

  local serialize_index
  do
    local name_separator = Syntels.name_separator
    local start_index = Syntels.start_index
    local end_index = Syntels.end_index

    local is_identifier = request('!.concepts.lua.is_identifier')

    serialize_index =
      function(Settings, Index)
        local Output = Settings.Output
        local index_value = Index[2]

        local brackets_not_required
        do
          local use_compact_indices = Settings.use_compact_indices
          local index_type = Index[1]
          brackets_not_required =
            use_compact_indices and
            ((index_type == type_string) and is_identifier(index_value))
        end

        if brackets_not_required then
          Output:Write(name_separator)
          Output:Write(index_value)
        else
          Output:Write(start_index)
          serialize_value(Settings, Index)
          Output:Write(end_index)
        end
      end
  end

  local kw_local = Syntels.kw_local
  local assign = Syntels.assign
  local statement_separator = Syntels.statement_separator
  local kw_return = Syntels.kw_return

  serialize_graph =
    function(Settings, GraphAst)
      local Output = Settings.Output

      for index, Rec in ipairs(GraphAst) do
        local rec_type = Rec[1]

        if (rec_type == type_local) then
          local name = Rec[2]
          local Value = Rec[3]

          Output:Write(kw_local)
          Output:Write(name)
          Output:Write(assign)
          serialize_value(Settings, Value)
        elseif (rec_type == type_assignment) then
          local dest_name = Rec[2]
          local Index = Rec[3]
          local src_name = Rec[4]

          Output:Write(dest_name)
          serialize_index(Settings, Index)
          Output:Write(assign)
          Output:Write(src_name)
        elseif (rec_type == type_return) then
          local Value = Rec[2]

          Output:Write(kw_return)
          serialize_value(Settings, Value)
        end

        Output:Write(statement_separator)
      end
    end
end

-- Export:
return serialize_graph

--[[
  2026 # # # # # #
]]
