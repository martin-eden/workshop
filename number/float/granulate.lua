-- Stick float number to middle of bucket

-- Last mod.: 2025-04-18

--[[
  Some abstractions illustration:

    Unit interval is [0.0, 1.0]:

      |-------------------------------|
      0.0                             1.0

    For two (2) buckets:

      |--------------||---------------|
      0.0    0.25    0.5     0.75    1.0

    So 0.25 and 0.75 appear to be middles for two buckets.
    And numbers in [0.0, 0.5) will become 0.25, [0.5, 1.0] will be 0.75.
]]

local Granulate =
  function(n, NumBuckets)
    assert((n >= 0.0) and (n <= 1.0))

    assert_integer(NumBuckets)
    assert(NumBuckets >= 1)

    -- Rare case n = 1.0, convert to something less than 1:
    if (n == 1.0) then
      n = 0.999
    end

    local BucketWidth = 1 / NumBuckets

    local BucketOffset = math.floor(n / BucketWidth)

    local Result = BucketOffset * BucketWidth + 0.5 * BucketWidth

    -- assert(Result <= 1.0, n)

    return Result
  end

-- Exports:
return Granulate

--[[
  2025-04-18
]]
