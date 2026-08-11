-- Graph serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

-- Imports:
local is_identifier = request('!.concepts.lua.is_identifier')
local TreeSerializer = request('TreeSerializer')

local SerializeGraph =
  function(Me, GraphAst, Output)
    local use_compact_indices = Me.Config.use_compact_indices
    local equal_str = Me.Config.equal_str

    for index, Rec in ipairs(GraphAst) do
      local rec_type = Rec[1]

      if (rec_type == 'local_definition') then
        local name = Rec[2]
        local Value = Rec[3]

        Output:Write('local')
        Output:Write(' ')
        Output:Write(name)
        Output:Write(equal_str)
        Me:SerializeValue(Value, Output)
        Output:Write('\n')
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
          Output:Write('.')
          Output:Write(key_value)
        else
          Output:Write('[')
          Me:SerializeValue(Key, Output)
          Output:Write(']')
        end
        Output:Write(equal_str)
        Output:Write(src_name)
        Output:Write('\n')
      elseif (rec_type == 'return_statement') then
        local Value = Rec[2]

        Output:Write('return')
        Output:Write(' ')
        Me:SerializeValue(Value, Output)
        Output:Write('\n')
      end
    end
  end

local Interface =
  {
    -- Main:
    SerializeGraph = SerializeGraph,

    -- Optional config:
    Config = new(TreeSerializer.Config),

    -- Internals:
    SerializeValue = TreeSerializer.SerializeValue,
    SerializeTree = TreeSerializer.SerializeTree,
  }

-- Export:
return Interface

--[[
  2026 # # #
  2026-08-11
]]
