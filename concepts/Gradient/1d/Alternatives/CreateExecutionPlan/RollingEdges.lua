-- "Rolling edges" execution plan

-- Last mod.: 2025-04-27

--[[

   1   2   3   4   5
  [L] [.] [.] [.] [R]

  produces

    (2 1 5)
    (4 2 5)
    (3 2 4)
]]
local RollineEgdesPlan =
  function(self)
    if (self.Line.Length <= 2) then
      return {}
    end

    local Result = {}

    local Left = 1
    local Right = self.Line.Length

    while true do
      do
        if (Left + 1 == Right) then
          break
        end

        table.insert(Result, { Left + 1, Left, Right })

        Left = Left + 1
      end

      do
        if (Right - 1 == Left) then
          break
        end

        table.insert(Result, { Right - 1, Left, Right })

        Right = Right - 1
      end
    end

    return Result
  end

-- Exports:
return RollineEgdesPlan

--[[
  2025-04-27
]]
