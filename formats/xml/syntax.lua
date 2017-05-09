--[[
  Based on XML 1.0 specification edition 5.

  Unicode is not supported (yet).

  THIS IS A PROTOTYPE (currently dormant)
]]

local handy = request('!.mechs.processor.handy')
local match_regexp = request('!.mechs.parser.handy').match_regexp
local any_char = request('!.mechs.parser.handy').any_char

local opt = handy.opt
local rep = handy.rep
local cho = handy.cho
local list = handy.list
local opt_rep = handy.opt_rep
local is_not = handy.is_not

local document =
  {
    name = 'document',
    prolog,
    element,
    opt_rep(Misc),
  }

local spc =
  cho(' ', '\x09', '\x0d', '\x0a')

return document
