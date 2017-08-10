--[[
  Broken!

  It occured to be a bad idea to place unit A in hive that changes
  another hive's units B.

  Case is when you call both this unit A and code that calls unit B and
  that relies on it's original behaviour.

  I'm disabling this chunk till normal resolution.
]]

--[[
local handy = request('!.mechs.processor.handy')
local any_char = request('!.mechs.parser.handy').any_char

local cho = handy.cho
local rep = handy.rep
local opt_rep = handy.opt_rep
local is_not = handy.is_not

local comment = request('syntax.words.comment')
comment.name = 'comment'  --here is the entry point for discrepancy
local type_string = request('syntax.type_string')
type_string.name = nil

return
  {
    opt_rep(
      cho(
        comment,
        {
          name = 'code',
          cho(type_string, any_char),
        }
      )
    ),
  }
]]
