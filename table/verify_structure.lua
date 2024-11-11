--[[
  Verify structure of given table versus reference table.

  We're checking that key in reference is present in sample.

  If third parameter is true then we're also checking that
  value types are same.

  If reference value is table, we'll dive into table and
  call ourselves for that subtable.

  Examples:

    True (no type checks):

      ({ FileHandle = 0 }, { FileHandle = io.stdin })

    False (type checks):

      ({ FileHandle = 0 }, { FileHandle = io.stdin }, true)
      ({ Answer = 42.0 }, { Answer = 42 }, true)

    False (missing key in sample):

      ({ FileHandle = nil }, { FileHandle = io.stdin })

    True (nested structure):

      (
        { Pixel = { Red = 128, Green = 128, Blue = 128 } },
        { Pixel = { Red = 0, Green = 0, Blue = 0 } }
      )

    False (missing structure in sample):

      (
        { Pixel = '#808080' },
        { Pixel = { Red = 0.0, Green = 1.0, Blue = 1.0 } }
      )
]]

-- Last mod.: 2024-11-11

local VerifyStructure
VerifyStructure =
  function(Sample, Reference, CheckTypes)
    assert_table(Sample)
    assert_table(Reference)

    for ReferenceKey, ReferenceValue in pairs(Reference) do
      local SampleValue = Sample[ReferenceKey]

      if is_nil(SampleValue) then
        return false
      end

      if CheckTypes then
        if (type(SampleValue) ~= type(ReferenceValue)) then
          return false
        end
      end

      if is_table(ReferenceValue) then
        if not is_table(SampleValue) then
          return false
        end
        if not VerifyStructure(SampleValue, ReferenceValue) then
          return false
        end
      end
    end

    -- Success if we're still alive
    return true
  end

-- Exports:
return VerifyStructure

--[[
  2020-09-13
  2024-11-11
]]
