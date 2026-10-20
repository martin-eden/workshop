-- Grammar for named function

--[[
  Author: Martin Eden
  Last mod.: 2026-10-25
]]

local handy = request('!.mechs.processor.handy')
local list = handy.list
local opt = handy.opt

local opt_spc = request('^.words.opt_spc')
local word = request('^.words.word')
local syntel = request('^.words.syntel')
local name = request('^.words.name')
local colon_name = request('^.wrappers.colon_name')
local function_body = request('function_body')

return
  {
    name = 'named_function',
    opt_spc,
    word('function'),
    {
      name = 'dot_list',
      list(name, syntel('.')),
    },
    opt(colon_name),
    function_body,
  }

--[[
  2016 #
  2018 # #
  2026-10-25
]]
