local any_byte = request('!.mechs.parser.handy').any_char
local store = request('functions.store')
local locate_rel = request('functions.locate_rel')

local signature = 'PK\x05\x06'

local find_signature =
  function(in_stream)
    local max_chunk_size = 64 * 1024 + 20 --possible 64KiB comment +20 bytes overhead
    in_stream:set_position(in_stream:get_length() - max_chunk_size + 1)
    if in_stream:match_regexp(signature) then
      in_stream:set_relative_position(-#signature)
      return true
    end
  end

local need_extended_rec =
  function(in_stream, out_stream)
    return (out_stream.int_data.files_list_offset == 0xFFFFFFFF)
  end

local extended_rec = request('files_list_link_i64')
local opt = request('!.mechs.processor.handy').opt

return
  {
    find_signature,
    {
      name = 'directory_end',
      {name = 'signature', signature},
      {name = 'current_disk_number', any_byte, any_byte},
      {name = 'start_disk_number', any_byte, any_byte},
      {name = 'num_entries_on_disk', any_byte, any_byte},
      {name = 'num_entries', any_byte, any_byte},
      {name = 'directory_size', any_byte, any_byte, any_byte, any_byte},
      {name = 'files_list_offset', store('files_list_offset', 4)},
      {name = 'comment_length', store('comment_len', 2)},
      {name = 'comment', locate_rel('comment_len')},
    },
    opt(need_extended_rec, extended_rec),
  }
