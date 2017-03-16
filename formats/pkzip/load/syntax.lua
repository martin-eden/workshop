local init_internal_storage = request('syntax.functions.init_internal_storage')
local files_list_link = request('syntax.files_list_link')
local files_list = request('syntax.files_list')
local files = request('syntax.files')

return
  {
    init_internal_storage,
    files_list_link,
    {name = 'files_list', files_list},
    {name = 'files_data', files},
  }
