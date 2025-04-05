-- Format constants and settings

-- Last mod.: 2025-03-30

--[[
  That's programmatic description "netpbm" family of formats.
]]

--[[
  "netpbm" family of formats

    https://netpbm.sourceforge.net/doc/#formats

  Well, there are fucking lot of annoying words but at core it's
  simple.

  We're dealing with images. Image is rectangular 2-d matrix of colors.
  So any image will have height and width.

  Color can be black/white (one bit), grayscale (1 to 16 bits) and
  RGB (24 bits).

  That color data can be encoded as plain text or as binary integers.

  That makes six variations.

  Also, one more format to rule them all "pam" - (p)ortable (a)rbitrary
  (m)ap. Late child to embrace them all and add "transparency"
  color component support.

    ( "pam" (P7) is not supported in this code. No practical need. )
]]

-- Color and data formats
local FormatLabels =
  {
    Text =
      {
        Bw = 'P1',
        Gs = 'P2',
        Rgb = 'P3',
      },
    Binary =
      {
        Bw = 'P4',
        Gs = 'P5',
        Rgb = 'P6',
      },
  }

-- Exports:
return
  {
    -- ( Map of available values
    FormatLabels = FormatLabels,
    -- )

    -- ( Actual location on that map
    ColorFormat = 'Rgb',
    DataEncoding = 'Text',
    GetFormatLabel = request('GetFormatLabel'),
    SetFormatLabel = request('SetFormatLabel'),
    -- )

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
  2025-03-30
]]
