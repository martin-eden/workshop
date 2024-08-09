-- Provide data tree for Lua table without cycles (for tree)

--[[
  /*
    That's a pseudocode. Implementation uses lowercase field names.
  */

  MakeTree(Data)
  ~~~~~~~~~~~~~~
    if not IsTable(Data)
      if
        @OnlyRestorableItems and
        (TypeOf(Data) not in @RestorableTypes)

        return

      Result.Type = TypeOf(Data)
      Result.Value = Data
      return

    if @NamedValues[Data]
      Result.Type = "name"
      Result.Value = Name of node. Used in cycled table serializer.
      return

    AssertTable(Data)

    Result.Type = "table"
    for (Key, Val) in Data
      Result[i] = { Key = MakeTree(Key), Value = MakeTree(Val) }
]]

local RestorableTypes =
  {
    ['boolean'] = true,
    ['number'] = true,
    ['string'] = true,
    ['table'] = true,
  }

return
  function(self, data)
    local result
    local data_type = type(data)
    if (data_type == 'table') then
      if self.value_names[data] then
        result =
          {
            type = 'name',
            value = self.value_names[data],
          }
      else
        result = {}
        result.type = 'table'
        for key, value in self.table_iterator(data) do
          if (
            self.OnlyRestorableItems and
              (
                not RestorableTypes[type(key)] or
                not RestorableTypes[type(value)]
              )
            )
          then
            goto next
          end
          local key_slot = self:get_ast(key)
          local value_slot = self:get_ast(value)
          result[#result + 1] =
            {
              key = key_slot,
              value = value_slot,
            }
        ::next::
        end
      end
    else
      result =
        {
          type = data_type,
          value = data,
        }
    end
    return result
  end

--[[
  2018-02
  2020-09
  2022-01
  2024-08
]]
