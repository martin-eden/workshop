-- Range methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-03
]]

--[[
  Data structure

    Start [i]
    Length [i]
]]

-- Export:
return
  {
    GetStart =
      function(Range)
        return Range.Start
      end,
    GetStop =
      function(Range)
        return Range.Start + Range.Length - 1
      end,
    GetLength =
      function(Range)
        return Range.Length
      end,
  }

--[[
  2026-04-30
  2026-05-01
  2026-05-03
]]
