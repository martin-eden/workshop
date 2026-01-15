-- Create space-filling plan

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

-- Imports:
local AreEqual = request('!.concepts.Geometry.TwoPoints.AreEqual')
local MoveToward = request('!.concepts.Geometry.Point.MoveToward')

--[[
  Generate space-filling plan

  Ideally we want function that creates plan to fill empty "pixels"
  given the knowledge of existing pixels. In N-dimensional space.

  In real world anything depends of everything. Any particle is
  influenced and influences all other particles.

  But here in Lua in 2026 we limit interface to function that is given
  coordinates of just two existing pixels. So newly generated pixels
  formally depend only from two "parents".


  Plan strategies

  You have A---B. Your plan is where to place C.

  I found two types of strategies:

    * Place as near to existing points as possible

      that means AC--B or A--CB

    * Place as far from existing points as possible

      that means A-C-B

  Now we have three points and question is which two of them
  will become parents for a new point.
]]
local CreateExecutionPlan =
  function(self, PointA, PointB)
    --[[
      Implementation uses "rolling edges" strategy:

        (A---B) -> A(C--B) -> A(C-D)B -> A(CE)DB

      We're moving one step from "left" point to "right" point.
      Then one step from "right" point to "left" point.
      Until we collide.

      WRONG Implementation is wrong. It generates path, not space-filling
    ]]
    local Result = {}

    local LeftPoint = PointA
    local RightPoint = PointB

    local MoveLeftPoint = true
    local NewPoint
    local DestPoint

    while not AreEqual(LeftPoint, RightPoint) do
      if MoveLeftPoint then
        NewPoint = new(LeftPoint)
        DestPoint = RightPoint
      else
        NewPoint = new(RightPoint)
        DestPoint = LeftPoint
      end

      MoveToward(NewPoint, DestPoint)

      -- Store creation step
      table.insert(Result, { NewPoint, LeftPoint, RightPoint })

      if MoveLeftPoint then
        LeftPoint = NewPoint
      else
        RightPoint = NewPoint
      end

      MoveLeftPoint = not MoveLeftPoint
    end

    return Result
  end


-- Exports:
return CreateExecutionPlan

-- 2026-01-14
