-- Character classifier interface/config

--[[
  Author: Martin Eden
  Last mod.: 2025-03-28
]]

local Space = { ' ', '\t' }
local Newline = { '\n', '\r' }

return
  {
    -- [Main]

    Init = request('Init'),

    IsSpace = request('IsSpace'),
    IsLineCommentStart = request('IsLineCommentStart'),
    IsLineCommentEnd = request('IsLineCommentEnd'),
    IsDelimiter = request('IsDelimiter'),

    -- [Config]
    Space = { Space, Newline },
    LineCommentStart = { '#' },
    LineCommentEnd = Newline,

    -- [Internals]
    SpaceMap = {},
    LineCommentStartMap = {},
    LineCommentEndMap = {},
  }

--[[
  2025-03-28
]]
