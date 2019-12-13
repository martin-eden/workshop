--[[
  Return interval of time at which alarm will be triggered.

  Alarm triggering time consist of time <offset> and recurrence
  <period>.

  Expects table with alarm time, produced by parser.

  Returns table with more manageble time representation, for structure
  see code. Also returns nil if given flags does not match recurrence.
]]

local match = request('multiplicity_to_period.match')
local fill_offset = request('multiplicity_to_period.fill_offset')

return
  function(alarm_rec)
    local result =
      {
        offset = nil,
        period = match(alarm_rec),
      }

    if not result.period then
      return
    end

    result.offset = fill_offset(result.period, alarm_rec)

    return result
  end
