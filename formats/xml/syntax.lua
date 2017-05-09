--[[
  Based on XML 1.0 specification edition 5.

  Unicode is not supported (yet).
]]

local parser = request('!.mechs.parser')
local handy = parser.handy

local opt = handy.opt
local rep = handy.rep
local cho = handy.cho
local rep_cho = handy.rep_cho
local list = handy.list
local opt_rep = handy.opt_rep
local opt_cho = handy.opt_cho
local opt_rep_cho = handy.opt_rep_cho
local is_not = handy.is_not
local match_regexp = handy.match_regexp

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
