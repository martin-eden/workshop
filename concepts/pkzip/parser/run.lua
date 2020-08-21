local process_locators_link = request('process_locators_link')
local process_locators = request('process_locators')
local process_files = request('process_files')

local default_options =
  {
    retrieve_file_data = false,
  }

return
  function(stream, options)
    options = new(default_options, options)

    local result = {}

    process_locators_link(stream, result)
    process_locators(stream, result)
    process_files(stream, result, options)

    return result
  end
