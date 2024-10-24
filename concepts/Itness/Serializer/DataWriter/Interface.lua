-- Data serialization functions

--[[
  This class knows nothing about structure and just writes to output
  syntax-specific strings and does value serialization.

  Interface

    .Output: [StreamIo.Output]

      Output implementer

    :StartList()

      Emit sequence opening

    :EndList()

      Emit sequence closure

    :WriteData(Data: str)

      Encode string value
]]

-- Last mod.: 2024-10-21

-- Imports:
local Output = request('!.concepts.StreamIo.Output')
local SyntaxChars = request('^.^.Syntax')
local ToList = request('!.table.to_list')
local MapValues = request('!.table.map_values')
local ListToString = request('!.concepts.List.ToString')
local QuoteRegexp = request('!.lua.regexp.quote')

local Exports =
  {
    -- [Config] Generic output. Caller should set it to concrete implementer.
    Output = Output,

    -- [Main] Emit opening sequence character
    StartList = request('StartList'),

    -- [Main] Emit closing sequence character
    EndList = request('EndList'),

    -- [Main] Serialize string
    WriteLeaf = request('WriteLeaf'),

    -- [Internal] Syntax characters categorization
    SyntaxChars = SyntaxChars,

    -- [Internal] Map of syntax characters. Defined later here
    IsSyntaxChar = {},

    -- [Internal] Syntax chars regexp. Defined later here
    SyntaxCharsRegexp = '',
  }

-- List of strings from folded table
local SyntaxCharsList = ToList(Exports.SyntaxChars)

-- "IsSyntaxChar[' '] = true"
Exports.IsSyntaxChar = MapValues(SyntaxCharsList)

-- Regexp describing any of our syntax characters
-- Lua blows on "[]", so contents should not be empty.
Exports.SyntaxCharsRegexp =
  '[' ..
  QuoteRegexp(ListToString(SyntaxCharsList)) ..
  ']'

-- Exports:
return Exports

--[[
  2024-09-03
  2024-10-20
]]
