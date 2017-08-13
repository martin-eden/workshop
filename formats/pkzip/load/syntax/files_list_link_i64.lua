local signature = 'PK\x06\x07'

local find_signature =
  function(in_stream)
    -- copy/paste from [files_list_link]:
    local max_chunk_size = 64 * 1024 + 20 --possible 64KiB comment +20 bytes overhead
    in_stream:set_position(in_stream:get_length() - max_chunk_size + 1)
    if in_stream:match_regexp(signature) then
      in_stream:set_relative_position(-#signature)
      return true
    end
  end

local any_byte = request('!.mechs.parser.handy').any_char
local store = request('functions.store')
local locate = request('functions.locate')

local dummy =
  function(size)
    assert_integer(size)
    assert(size >= 1)
    assert(size <= 128)
    local result = {}
    for i = 1, size do
      result[i] = any_byte
    end
    return result
  end

return
  {
    find_signature,
    {
      name = 'directory_end_ref',
      {name = 'signature', signature},
      {name = 'start_disk_number', any_byte, any_byte, any_byte, any_byte},
      {name = 'directory_end_i64_offs', store('directory_end_i64_offs', 8)},
      {name = 'num_disks', any_byte, any_byte, any_byte, any_byte},
    },
    locate('directory_end_i64_offs'),
    {
      name = 'directory_end_i64',
      {name = 'signature', 'PK\x06\x06'},
      {name = 'structure_size', dummy(8)},
      {name = 'version_made_by', any_byte, any_byte},
      {name = 'version_to_extract', any_byte, any_byte},
      {name = 'current_disk_number', dummy(4)},
      {name = 'start_disk_number', dummy(4)},
      {name = 'num_entries_on_disk', dummy(8)},
      {name = 'num_entries', dummy(8)},
      {name = 'directory_size', dummy(8)},
      {name = 'files_list_offset', store('files_list_offset', 8)},
    },
  }
