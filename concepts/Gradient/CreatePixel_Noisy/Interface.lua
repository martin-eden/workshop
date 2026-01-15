-- Export CreatePixel() function that introduces distance noise

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

--[[
  Design problem

  Stock CreatePixel() calls self.Image:GetPixel() and
  self.Image:SetPixel(). We don't want to touch their implementation.

  We're doing noisy observations, adding distance-dependent noise
  to anchor points. There's no such stuff in stock implementation of
  GetPixel(). It will always return "real" value of pixel.
  While we need dependence of distance to observed pixel.

  There is no sense in replacing GetPixel() with new one with
  extended list of arguments. It will be called old way.


  Our solution

  We're separate module. We don't afford direct CreatePixel() function
  after require(). To get it you need to call us like

    CreatePixel = NoisyCreatePixel:Generate_CreatePixel()

  Generate_CreatePixel() will save our class as sort of upvalue that
  will be passed to our internal CreatePixel().

  So there we will have stock "self" which is virgin and our
  personal "self". And our CreatePixel() will call ours
  "self" method ObservePixel() which will respect distance.
  And then we will call theirs "self" method SetPixel().
]]

-- Exports:
return
  {
    -- [In]
    PixelsPerDistance = 400,
    GetDistanceNoiseAmplitude = request('GetDistanceNoiseAmplitude'),

    -- [Run]
    Generate_CreatePixel = request('Generate_CreatePixel'),

    -- [Internals]
    MakeDistanceNoise = request('MakeDistanceNoise'),
    ObservePixel = request('ObservePixel'),
    CreatePixel = request('CreatePixel'),
  }

--[[
  2025-04-23
  2025-04-26
  2025-04-28
  2026-01-13
]]
