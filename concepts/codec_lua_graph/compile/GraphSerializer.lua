-- Graph serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-08-15
]]

-- Imports:
local is_identifier = request('!.concepts.lua.is_identifier')
local TreeSerializer = request('TreeSerializer')

local SerializeGraph =
  function(Me, GraphAst)
    local Output = Me.Output
    local Writer = Me.Writer

    local use_compact_indices = Me.use_compact_indices

    for index, Rec in ipairs(GraphAst) do
      local rec_type = Rec[1]

      if (rec_type == 'local_definition') then
        local name = Rec[2]
        local Value = Rec[3]

        Writer:Keyword_Local()
        Output:Write(name)
        Writer:Assign()
        Me:SerializeValue(Value)
        Writer:EndStatement()
      elseif (rec_type == 'key_assignment') then
        local dest_name = Rec[2]
        local Key = Rec[3]
        local src_name = Rec[4]

        local key_type = Key[1]
        local key_value = Key[2]

        local brackets_not_required =
          use_compact_indices and
          ((key_type == 'string') and is_identifier(key_value))

        Output:Write(dest_name)
        if brackets_not_required then
          Writer:SeparateName()
          Output:Write(key_value)
        else
          Writer:StartIndex()
          Me:SerializeValue(Key)
          Writer:EndIndex()
        end
        Writer:Assign()
        Output:Write(src_name)
        Writer:EndStatement()
      elseif (rec_type == 'return_statement') then
        local Value = Rec[2]

        Writer:Keyword_Return()
        Me:SerializeValue(Value)
        Writer:EndStatement()
      end
    end
  end

local Interface =
  {
    -- Main:
    SerializeGraph = SerializeGraph,

    -- Internals:
    SerializeValue = TreeSerializer.SerializeValue,
    SerializeTree = TreeSerializer.SerializeTree,
  }

-- Export:
return Interface

--[[
  2026 # # #
  2026-08-11
  2026-08-15
]]
