-- 2-d bilinear gradient generator

-- Last mod.: 2025-04-29

local t2s = request('!.table.as_string')
local OutputFile = request('!.concepts.StreamIo.Output.File')
local PpmCodec = request('!.concepts.Netpbm.Interface')

local Generate =
  function(self)
    --[[
      Task is to calculate gradient filling of image rectangle
      specified by corner colors.
    ]]

    local Plan = self:CreateExecutionPlan()

    for PlanEntryIndex, PlanEntry in ipairs(Plan) do
      local Mode = PlanEntry[1]

      if (Mode == 'H') then
        self:HStroke(PlanEntry[2], PlanEntry[3], PlanEntry[4])
      elseif (Mode == 'V') then
        self:VStroke(PlanEntry[2], PlanEntry[3], PlanEntry[4])
      end

      --[[
      do
        local Mode = PlanEntry[1]
        local What = PlanEntry[2]
        local From = PlanEntry[3]
        local To = PlanEntry[4]

        local FileName =
          ('%d_%s_%d__%d_%d.ppm'):
          format(PlanEntryIndex, Mode, What, From, To)

        OutputFile:Open(FileName)

        PpmCodec.Output = OutputFile
        PpmCodec.Settings.ColorFormat = self.ColorFormat
        PpmCodec:Save(self.Image)

        OutputFile:Close()
      end
      --]]
    end
  end

-- Exports:
return Generate

--[[
  2024-04-15
  2024-04-16
  2025-04-27
  2025-04-28
  2025-04-29
]]
