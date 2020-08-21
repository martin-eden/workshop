--[[
  Mapping of frequency (integer in Hz) to frequency id.
]]

local invert = request('!.table.invert')
local wave_freqs = request('wave_freqs')

return invert(wave_freqs)
