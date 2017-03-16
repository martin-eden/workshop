local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local any_byte = request('!.mechs.parser.handy').any_char

return
  {
    name = 'data_descriptor',
    opt({name = 'signature', 'PK\x07\x08'}),
    {name = 'crc_32', any_byte, any_byte, any_byte, any_byte},
    {name = 'compressed_size',  any_byte, any_byte, any_byte, any_byte},
    {name = 'original_size', any_byte, any_byte, any_byte, any_byte},
  }
