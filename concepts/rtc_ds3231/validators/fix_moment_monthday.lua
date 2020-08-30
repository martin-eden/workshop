--[[
  Change month day to some valid number.

  Generating valid monthday depends whether year is leap and
  month. So we pass month and year to generator.

  <report> practically is nil and not used.
]]

local generate_monthday = request('!.concepts.date.generate_monthday')

return
  function(data, report)
    data.moment.date =
      generate_monthday(data.moment.month, data.moment.year)
  end
