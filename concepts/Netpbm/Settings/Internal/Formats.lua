-- Mapping from our data type record to NetPBM string signature

--[[
  Author: Martin Eden
  Last mod.: 2026-01-25
]]

--[[
  Description of color and data encoding formats

  Key names are important. They are used as values for interface fields
  <DataEncoding> and <ColorFormat>.

  After some thoughts we decided to import here comment text for
  signature and number of color channels from compiler.
]]

local FormatLabels =
  {
    text =
      {
        bw =
          {
            Signature = 'P1',
            Comment = 'Bitmap, text format',
            NumChannels = 1,
          },
        gs =
          {
            Signature = 'P2',
            Comment = 'Grayscale, text format',
            NumChannels = 1,
          },
        rgb = 'P3',
          {
            Signature = 'P3',
            Comment = 'Color, text format',
            NumChannels = 3,
          },
      },
    binary =
      {
        bw =
          {
            Signature = 'P4',
            Comment = 'Bitmap, binary format',
            NumChannels = 1,
          },
        gs =
          {
            Signature = 'P5',
            Comment = 'Grayscale, binary format',
            NumChannels = 1,
          },
        rgb =
          {
            Signature = 'P6',
            Comment = 'Color, binary format',
            NumChannels = 3,
          },
      },
  }

-- Export:
return FormatLabels

--[[
  2025-04-01
  2025-04-09
  2026-01-25
]]
