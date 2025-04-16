-- 2-d bilinear gradient generator

-- Last mod.: 2025-04-15

-- Imports:
local OneDGenerator = request('!.concepts.Gradient.1d.Fractal.Interface')

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

      We use last one because thus way we can reuse linear gradient
      generator.
    ]]

    OneDGenerator.ColorFormat = self.ColorFormat

    local Right = Left + Width - 1
    local Bottom = Top + Height - 1

    -- Top rail
    do
      OneDGenerator.LineLength = Width

      OneDGenerator.StartColor = self.StartingColors.Left.Top
      OneDGenerator.EndColor = self.StartingColors.Right.Top

      OneDGenerator:Run()

      for Index = 1, OneDGenerator.Line.Length do
        self:SetColor(
          OneDGenerator.Line[Index], { X = Left + Index - 1, Y = Top }
        )
      end
    end

    -- Bottom rail
    do
      OneDGenerator.LineLength = Width

      OneDGenerator.StartColor = self.StartingColors.Left.Bottom
      OneDGenerator.EndColor = self.StartingColors.Right.Bottom

      OneDGenerator:Run()

      for Index = 1, OneDGenerator.Line.Length do
        self:SetColor(
          OneDGenerator.Line[Index], { X = Left + Index - 1, Y = Bottom }
        )
      end
    end

    -- Lines between rails
    do
      OneDGenerator.LineLength = Height

      for X = Left, Right do
        OneDGenerator.StartColor = self:GetColor({ X = X, Y = Top })
        OneDGenerator.EndColor = self:GetColor({ X = X, Y = Bottom})

        OneDGenerator:Run()

        for Index = 2, OneDGenerator.Line.Length - 1 do
          self:SetColor(
            OneDGenerator.Line[Index], { X = X, Y = Top + Index - 1 }
          )
        end
      end
    end

  end

-- Exports:
return Generate

--[[
  2024-04-15
]]
