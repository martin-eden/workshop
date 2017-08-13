local any_byte = request('!.mechs.parser.handy').any_char
local store = request('functions.store')
local locate_rel = request('functions.locate_rel')

local directory_end_sign = 'PK\x05\x06'

local find_rec =
  function(in_stream)
    local max_chunk_size = 64 * 1024 + 20 --possible 64KiB comment +20 bytes overhead
    in_stream:set_position(in_stream:get_length() - max_chunk_size + 1)
    if in_stream:match_regexp(directory_end_sign) then
      in_stream:set_relative_position(-#directory_end_sign)
      return true
    end
  end

return
  {
    find_rec,
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
    },
  }
