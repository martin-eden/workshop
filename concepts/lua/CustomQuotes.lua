-- Return list of character quotes

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

--[[
  Output data format

  List of entries

    [t]
      1 [i] ASCII code
      2 [t] List of quote ASCII codes
          [i] ASCII code
]]

--[[
  ASCII code 7 (BEL aka "bell" aka "alarm") may be quoted as
  ASCII codes 92 97 ('\a') in Lua.

    ( Also it may be quoted as '\007' or '\x07' or left as is.
      But it's out of scope of this module. )
]]

local CustomQuotes =
  {
    { 07, { 092, 097 } },
    { 08, { 092, 098 } },
    { 09, { 092, 116 } },
    { 10, { 092, 110 } },
    { 11, { 092, 118 } },
    { 12, { 092, 102 } },
    { 13, { 092, 114 } },
    { 34, { 092, 034 } },
    { 39, { 092, 039 } },
    { 92, { 092, 092 } },
  }

-- Export:
return CustomQuotes

--[[
  2016
  2026-07-11
]]
