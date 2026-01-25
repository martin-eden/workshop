-- Format constants and settings

--[[
  Author: Martin Eden
  Last mod.: 2026-01-25
]]

--[[
  That's programmatic description of "netpbm" family of formats.
]]

--[[
  "netpbm" family of formats

    https://netpbm.sourceforge.net/doc/#formats

  Well there are fucking lot of annoying words but at core it's simple.

  We're dealing with images. Image is rectangular 2-d matrix of colors.
  So any image will have height and width.

  * Color can be

      * black/white (one bit)
      * grayscale (1 to 16 bits)
      * RGB (24 bits)

  * Color data can be encoded as

    * plain text
    * binary integers

  That makes six variations.

  Also one more format to rule them all "pam" - (p)ortable (a)rbitrary
  (m)ap. Late child to embrace them all and add "transparency" color
  component support. It is not supported in this code. No need.
]]

-- Exports:
return
  {
    -- [Internal] Mapping for available format signatures
    Formats = request('Internal.Formats'),
    -- ( Actual location on that map
    ColorFormat = 'rgb',
    DataEncoding = 'text',
    -- )
    -- Get format signature from Color Format and Data Encoding
    GetFormatLabel = request('GetFormatLabel'),
    -- Set Color Format and Data Encoding from format signature
    SetFormatLabel = request('SetFormatLabel'),

    -- Line comment character
    LineCommentChar = '#',

    --[[
      Max color component value

      Format allows any integer in [1, 65535]. But we're fixing it
      to 255 because it's the only value we need.
    ]]
    MaxColorValue = 255,
  }

--[[
  2024-11-02
  2025-03-29
  2025-04-01
  2026-01-15
  2026-01-25
]]
