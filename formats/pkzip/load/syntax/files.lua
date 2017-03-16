local handy = request('!.mechs.processor.handy')
local cho = handy.cho
local is_not = handy.is_not
local opt_rep = handy.opt_rep

local any_byte = request('!.mechs.parser.handy').any_char

local store = request('functions.store')
local locate_rel = request('functions.locate_rel')
local load_data = request('functions.load_data')
local bit_3_is_set = request('functions.bit_3_is_set')

local data_descriptor = request('file_post_rec')

local local_file_header =
  {
    name = 'local_file_header',
    {name = 'signature', 'PK\x03\x04'},
    {name = 'version_to_extract', any_byte, any_byte},
    {name = 'bit_flag', store('bit_flag', 2)},
    {name = 'compression_method', any_byte, any_byte},
    {name = 'file_time', any_byte, any_byte},
    {name = 'file_date', any_byte, any_byte},
    {name = 'crc_32', any_byte, any_byte, any_byte, any_byte},
    {name = 'compressed_size', any_byte, any_byte, any_byte, any_byte},
    {name = 'original_size', any_byte, any_byte, any_byte, any_byte},
    {name = 'filename_length', store('filename_len', 2)},
    {name = 'additional_data_length', store('add_data_len', 2)},
    {name = 'filename', locate_rel('filename_len')},
    {name = 'additional_data', locate_rel('add_data_len')},
    {name = 'data', load_data},
    cho(
      is_not(bit_3_is_set),
      {bit_3_is_set, data_descriptor}
    )
  }

local init_slots_pos = request('functions.init_slots_pos')
local next_slot = request('functions.next_slot')
local locate_file = request('functions.locate_file')

return
  {
    init_slots_pos,
    opt_rep(
      next_slot,
      locate_file,
      local_file_header
    ),
  }
