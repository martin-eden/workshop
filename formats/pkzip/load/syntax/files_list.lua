local handy = request('!.mechs.processor.handy')
local opt_rep = handy.opt_rep
local opt = handy.opt

local any_byte = request('!.mechs.parser.handy').any_char
local store = request('functions.store')
local locate_rel = request('functions.locate_rel')
local store_compressed_size = request('functions.store_compressed_size')
local store_file_offset = request('functions.store_file_offset')

local file_header =
  {
    name = 'file_header',
    {name = 'signature', 'PK\x01\x02'},
    {name = 'version_to_extract', any_byte, any_byte},
    {name = 'version_made_by', any_byte, any_byte},
    {name = 'bit_flag', any_byte, any_byte},
    {name = 'compression_method', any_byte, any_byte},
    {name = 'file_time', any_byte, any_byte},
    {name = 'file_date', any_byte, any_byte},
    {name = 'crc_32', any_byte, any_byte, any_byte, any_byte},
    {name = 'compressed_size', store_compressed_size},
    {name = 'original_size', any_byte, any_byte, any_byte, any_byte},
    {name = 'filename_length', store('filename_len', 2)},
    {name = 'additional_data_length', store('add_data_len', 2)},
    {name = 'comment_length', store('comment_len', 2)},
    {name = 'start_disk', any_byte, any_byte},
    {name = 'internal_file_attributes', any_byte, any_byte},
    {name = 'external_file_attributes', any_byte, any_byte, any_byte, any_byte},
    {name = 'file_offset', store_file_offset},
    {name = 'filename', locate_rel('filename_len')},
    {name = 'additional_data', locate_rel('add_data_len')},
    {name = 'comment', locate_rel('comment_len')},
  }

local locate = request('functions.locate')
local init_slots = request('functions.init_slots')
local init_slots_pos = request('functions.init_slots_pos')
local next_slot = request('functions.next_slot')
local init_slot = request('functions.init_slot')
local free_unfinished_slot = request('functions.free_unfinished_slot')

return
  {
    locate('files_list_offset'),
    init_slots,
    init_slots_pos,
    opt_rep(
      opt(next_slot),
      init_slot,
      file_header
    ),
    free_unfinished_slot,
  }
