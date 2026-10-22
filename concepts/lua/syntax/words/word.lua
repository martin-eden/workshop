-- Grammar for word. Used for keywords

--[[
  Author: Martin Eden
  Last mod.: 2026-10-22
]]

local opt_spc = request('opt_spc')
local match_regexp = request('!.mechs.parser.handy').match_regexp

local not_name_body_letter = '%f[^_A-Za-z0-9]'

return
  function(str)
    return
      {
        opt_spc,
        match_regexp(str .. not_name_body_letter),
      }
  end

--[[
  2018 # #
  2026-10-22
]]
