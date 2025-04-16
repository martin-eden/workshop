-- 2-d bilinear gradient generator

-- Last mod.: 2025-04-16

local Generate =
  function(self, Left, Top, Width, Height)
    --[[
      Task is to calculate gradient filling of image rectangle
      specified by corner colors.

      We can use sexy recursive filling:
        * find longest sides (width or height)
        * set middle pixels of longest sides
        * call itself for two rectangles (with common side
          at middles of longest sides)

      Currently this algorithm is used in fractal noise generation.
      We want decreasing rectangle sides there to generate local noise.

      But more dumber algorithm is just
        * build linear gradients at top and bottom (or at left and right,
          does not matter)
        * build linear gradients between top and bottom

      We use last one because thus way we can better reuse linear
      gradient generator.
    ]]

    local LinearGenerator = self.LinearGenerator

    LinearGenerator.ColorFormat = self.ColorFormat

    local Right = Left + Width - 1
    local Bottom = Top + Height - 1

    -- Top rail
    do
      LinearGenerator.LineLength = Width

      LinearGenerator.StartColor = self.StartingColors.Left.Top
      LinearGenerator.EndColor = self.StartingColors.Right.Top

      LinearGenerator:Run()

      for Index = 2, LinearGenerator.Line.Length - 1 do
        self:SetPixel(
          LinearGenerator.Line[Index], { X = Left + Index - 1, Y = Top }
        )
      end
    end

    -- Bottom rail
    do
      LinearGenerator.LineLength = Width

      LinearGenerator.StartColor = self.StartingColors.Left.Bottom
      LinearGenerator.EndColor = self.StartingColors.Right.Bottom

      LinearGenerator:Run()

      for Index = 2, LinearGenerator.Line.Length - 1 do
        self:SetPixel(
          LinearGenerator.Line[Index], { X = Left + Index - 1, Y = Bottom }
        )
      end
    end

    -- Lines between rails
    do
      LinearGenerator.LineLength = Height

      for X = Left, Right do
        LinearGenerator.StartColor = self:GetPixel({ X = X, Y = Top })
        LinearGenerator.EndColor = self:GetPixel({ X = X, Y = Bottom})

        LinearGenerator:Run()

        for Index = 2, LinearGenerator.Line.Length - 1 do
          self:SetPixel(
            LinearGenerator.Line[Index], { X = X, Y = Top + Index - 1 }
          )
        end
      end
    end
  end

-- Exports:
return Generate

--[[
  2024-04-15
  2024-04-16
]]
