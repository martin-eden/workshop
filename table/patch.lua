-- Apply patch to table

--[[
  Status: should work
  Version: 2
  Last mod.: 2024-02-11
]]

--[[
  Example

    local MainConfig =
      {
        Name = 'PathName',
        PathName = { Path = 'Data/Results/', Name = 'Default.json'},
      }

    local PatchConfig =
      {
        PathName = { Name = 'Custom.json' },
      }

    DoPatch(MainConfig, PatchConfig)
]]

local DoPatch
DoPatch =
  function(MainTable, PatchTable)
    assert_table(MainTable)
    assert_table(PatchTable)

    for PatchKey, PatchValue in pairs(PatchTable) do
      -- We work only with string and integer keys in patch table
      if (is_string(PatchKey) or is_integer(PatchKey)) then
        local MainValue = MainTable[PatchKey]

        -- Raise error if main table doesn't have patch key
        if is_nil(MainValue) then
          local ErrorMsg =
            ([[Destination table doesn't have key "%s".]]):
            format(
              tostring(PatchKey)
            )

          error(ErrorMsg, 2)
        end

        -- Recursive call when we writing table to table
        if is_table(MainValue) and is_table(PatchValue) then
          DoPatch(MainValue, PatchValue)
        -- Else just overwrite value
        else
          MainTable[PatchKey] = PatchValue
        end
      end
    end
  end

return DoPatch
