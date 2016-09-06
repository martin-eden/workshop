local parser = request('^.parser')
local handy = parser.handy

--[[
	Data sample:

	\Documents and Settings\All Users\Documents\My Pictures
	\Documents and Settings\All Users\Documents\My Pictures\Sample Pictures
	\Documents and Settings\All Users\Documents\My Videos
]]

local records =
	handy.list(
		{
			name = 'record',
			handy.rep(
				[[\]],
				{
					name = 'field',
					handy.match_pattern('[^%\x5C\n]*')
				}
			)
		},
		'\n'
	)

return records
