-- "Rolling edges" execution plan

-- Last mod.: 2025-04-27

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
