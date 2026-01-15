-- Image filling interface

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

-- GetPixel() exposure
local GetPixel_Export =
  function(self, Path)
    local Image = self.Image
    return Image:GetPixel(Path)
  end

-- SetPixel() exposure
local SetPixel_Export =
  function(self, Path, Color)
    local Image = self.Image
    return Image:SetPixel(Path, Color)
  end

return
  {
    -- [Config]
    Image = request('!.concepts.Image.Interface'),
    CreatePixel = request('CreatePixel'),
    CreateExecutionPlan = request('CreateExecutionPlan'),
    ExecutePlan = request('ExecutePlan'),
    -- [Run]
    Run = request('Run'),
    -- [Internal]
    GetPixel = GetPixel_Export,
    SetPixel = SetPixel_Export,
  }

-- 2026-01-14
