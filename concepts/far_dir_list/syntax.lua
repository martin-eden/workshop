local handy = request('!.mechs.processor.handy')
local match_regexp = request('!.mechs.parser.handy').match_regexp

--[[
  Data sample:

  \Documents and Settings\All Users\Documents\My Pictures
  \Documents and Settings\All Users\Documents\My Pictures\Sample Pictures
  \Documents and Settings\All Users\Documents\My Videos
]]

return
  handy.list(
    {
      name = 'record',
      handy.rep(
        [[\]],
        {
          name = 'field',
          match_regexp('[^%\x5C\n]*')
        }
      )
    },
    '\n'
  )
