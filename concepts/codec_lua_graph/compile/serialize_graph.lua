-- Graph serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-08-20
]]

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

  local serialize_value = request('serialize_tree')
  local is_identifier = request('!.concepts.lua.is_identifier')

  serialize_graph =
    function(Settings, GraphAst)
      local Output = Settings.Output
      local Write = Settings.Writer

      local use_compact_indices = Settings.use_compact_indices

      for index, Rec in ipairs(GraphAst) do
        local rec_type = Rec[1]

        if (rec_type == type_local) then
          local name = Rec[2]
          local Value = Rec[3]

          Write:Keyword_Local()
          Output:Write(name)
          Write:Assign()
          serialize_value(Settings, Value)
          Write:EndStatement()
        elseif (rec_type == type_assignment) then
          local dest_name = Rec[2]
          local Key = Rec[3]
          local src_name = Rec[4]

          local key_type = Key[1]
          local key_value = Key[2]

          local brackets_not_required =
            use_compact_indices and
            ((key_type == type_string) and is_identifier(key_value))

          Output:Write(dest_name)
          if brackets_not_required then
            Write:SeparateName()
            Output:Write(key_value)
          else
            Write:StartIndex()
            serialize_value(Settings, Key)
            Write:EndIndex()
          end
          Write:Assign()
          Output:Write(src_name)
          Write:EndStatement()
        elseif (rec_type == type_return) then
          local Value = Rec[2]

          Write:Keyword_Return()
          serialize_value(Settings, Value)
          Write:EndStatement()
        end
      end
    end
end

-- Export:
return serialize_graph

--[[
  2026 # # # # # #
]]
