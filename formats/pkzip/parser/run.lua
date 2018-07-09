local process_locators_link = request('process_locators_link')
local process_locators = request('process_locators')
local process_files = request('process_files')

return
  function(stream)
    local result = {}

    process_locators_link(stream, result)
    process_locators(stream, result)
    process_files(stream, result)

    return result
  end
