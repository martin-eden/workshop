-- Format constants

-- Last mod.: 2024-11-02

-- Exports:
return
  {
    -- Format label
    FormatLabel = 'P3',

    --[[
       Max color component value

       Despite that format allows any integer in [1, 65535]
       we're fixing it to constant.

       Color component value should be between 0 and this number.
    ]]
    MaxColorValue = 255,

    -- Check that given string is our format label
    IsValidLabel = request('IsValidLabel'),
  }

--[[
  2024-11-02
]]
