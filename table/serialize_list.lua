-- Serialize table sequence

--[[
  Input

    table - items

      Sequence of items.

    function - serializer

      Item serializer. Should return "string".

      If your items are just strings or integers, you can
      pass "tostring()" global function.

    string - separator

      Item list separator string.

      Typical values are "," and ", ".

  Output

    string

      Result of item serializers.
]]

-- Last mod.: 2024-03-04

return
  function(Items, Serializer, Separator)
    assert_table(Items)
    assert_function(Serializer)
    assert_string(Separator)

    local Result
    do
      local ItemsStr = {}
      for _, Item in ipairs(Items) do
        local ItemStr = Serializer(Item)
        assert_string(ItemStr)
        table.insert(ItemsStr, ItemStr)
      end
      Result = table.concat(ItemsStr, Separator)
    end
    assert_string(Result)

    return Result
  end

--[[
  2024-03-04
]]
