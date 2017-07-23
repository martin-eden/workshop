local extract_date = request('extract_date')
local extract_number = request('extract_number')

return
  function(block, result)
    result.date = extract_date(block)
    result.number = extract_number(block)
  end
