local any_byte = request('!.mechs.parser.handy').any_char
local store = request('functions.store')
local locate_rel = request('functions.locate_rel')
local directory_end_sign = request('directory_end_sign')

local directory_end =
  {
    name = 'directory_end',
    {name = 'signature', directory_end_sign},
    {name = 'current_disk_number', any_byte, any_byte},
    {name = 'start_disk_number', any_byte, any_byte},
    {name = 'num_entries_on_disk', any_byte, any_byte},
    {name = 'num_entries', any_byte, any_byte},
    {name = 'directory_size', any_byte, any_byte, any_byte, any_byte},
    {name = 'files_list_offset', store('files_list_offset', 4)},
    {name = 'comment_length', store('comment_len', 2)},
    {name = 'comment', locate_rel('comment_len')},
  }

local locate_directory_end = request('functions.locate_directory_end')

return
  {
    locate_directory_end,
    directory_end,
  }
