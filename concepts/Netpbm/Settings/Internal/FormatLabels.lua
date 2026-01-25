-- Mapping from our data type record to NetPBM string signature

--[[
  Author: Martin Eden
  Last mod.: 2026-01-25
]]

--[[
  Color and data formats

  Key names are important. They are used as values for interface fields
  <DataEncoding> and <ColorFormat>.
]]
local FormatLabels =
  {
    text =
      {
        bw = 'P1',
        gs = 'P2',
        rgb = 'P3',
      },
    binary =
      {
        bw = 'P4',
        gs = 'P5',
        rgb = 'P6',
      },
  }

-- Export:
return FormatLabels

--[[
  2025-04-01
  2026-01-25
]]
