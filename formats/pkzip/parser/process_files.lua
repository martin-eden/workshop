--[[
  Process file records.

  Populates <result>. Changes stream position.

  Algorithm

    for locator in locators
      file_offs = locator.file_offs
      if file_offs = 0xFFFFFFFF
        file_offs = locator.extra_rec.file_offs

      seek(file_offs)

      file_rec = parse_file_rec()

      bit_3 = file_rec.bit_flag[3]
      if bit_3
        data_size = locator.compressed_size
        if data_size = 0xFFFFFFFF
          data_size = locator.extra_rec.compressed_size
      else
        data_size = file_rec.compressed_size
        if data_size = 0xFFFFFFFF
          data_size = file_rec.extra_rec.compressed_size

      seek(+data_size)

      if bit_3
        file_rec.post_rec = parse_post_rec()

      store(file_rec)
]]

local parse_file_rec = request('parse.file_rec')
local parse_post_file_rec = request('parse.post_file_rec')
local locate_zip64_rec = request('locate_zip64_rec')
local name_zip64_fields_file_rec = request('name_zip64_fields_file_rec')
local get_data_size = request('get_data_size')

local FFx4 = 0xFFFFFFFF

return
  function(stream, result, options)
    result.files = {}
    for i = 1, #result.locators do
      local locator = result.locators[i]

      -- Get file record offset:
      local file_offset = locator.file_offset
      -- Offset too big so stored in Zip64 record?
      if (file_offset == FFx4) then
        local zip64_rec = locate_zip64_rec(locator)
        if zip64_rec then
          file_offset = zip64_rec.file_offset
        end
      end

      stream:set_position(file_offset + 1)

      local file_rec = parse_file_rec(stream)
      if is_table(file_rec.extra_data) then
        name_zip64_fields_file_rec(file_rec)
      end

      local data_size = get_data_size(locator)

      if options and options.retrieve_file_data then
        file_rec.data = stream:read(data_size)
      else
        stream:set_relative_position(data_size)
      end

      local bit_3_is_set =
        ('< I2'):unpack(file_rec.bit_flag) & (1 << 2) > 0

      if bit_3_is_set then
        file_rec.post_rec = parse_post_file_rec(stream)
      end

      result.files[i] = file_rec
    end
  end
