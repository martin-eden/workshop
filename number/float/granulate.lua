-- Stick float number to middle of bucket

-- Last mod.: 2025-04-26

-- Imports:
local constrain_ui = request('!.number.constrain_ui')
local is_natural = request('!.number.is_natural')
local to_int = math.floor

--[[
  Some abstractions illustration:

    Unit interval is [0.0, 1.0]:

       |-------------------------------|
      0.0                             1.0

    For two buckets:

       |--------------||---------------|
      0.0    0.25    0.5     0.75     1.0

    So 0.25 and 0.75 are middles of two buckets.
    And numbers from [0.0, 0.5) will become 0.25,
    numbers from [0.5, 1.0] will become 0.75.
]]

local Granulate =
  function(n, NumBuckets)
    n = constrain_ui(n)

    assert(is_natural(NumBuckets))

    local BucketWidth = 1 / NumBuckets

    local BucketOffset = to_int(n / BucketWidth)

    -- Only for <n> == 1.0, <BucketOffset> will be <n>
    if (BucketOffset == NumBuckets) then
      BucketOffset = NumBuckets - 1
    end

    local Result = BucketOffset * BucketWidth + 0.5 * BucketWidth

    -- assert(Result <= 1.0, n)

    return Result
  end

-- Exports:
return Granulate

--[[
  2025-04-18
  2025-04-26
]]
