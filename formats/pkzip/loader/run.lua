local max_ui4 = 0xFFFFFFFF

return
  function(self)
    local signatures = self.signatures
    local in_stream = self.in_stream
    local result = {}
    if self:locate_signature(signatures.files_list_link) then

      -- Getting link to files list.

      local file_recs_offs
      local num_file_recs

      result.files_list_link = self:parse_files_list_link()
      if
        (result.files_list_link.files_list_offset == max_ui4) and
        self:locate_signature(signatures.files_list_link_link)
      then
        result.files_list_link_link = self:parse_files_list_link_link()
        in_stream:set_position(result.files_list_link_link.next_rec_offset + 1)
        result.files_list_link_64 = self:parse_files_list_link_64()
        file_recs_offs = result.files_list_link_64.files_list_offset
        num_file_recs = result.files_list_link_64.num_entries_on_disk
      else
        file_recs_offs = result.files_list_link.files_list_offset
        num_file_recs = result.files_list_link.num_entries_on_disk
      end

      -- Reading files list.

      in_stream:set_position(file_recs_offs + 1)

      result.file_recs = {}
      for i = 1, num_file_recs do
        local rec = self:parse_file_header()

        local additional_data = rec.additional_data
        if (additional_data ~= '') then
          rec.additional_data = self:parse_additional_data(additional_data)
          if rec.additional_data.zip64 then
            self:fill_zip64(rec)
          end
        end

        result.file_recs[i] = rec
      end

      -- Reading local file headers.

      result.local_file_recs = {}
      for i = 1, #result.file_recs do
        local file_rec = result.file_recs[i]
        local file_offset = file_rec.file_offset
        if
          (file_offset == max_ui4) and
          file_rec.additional_data and
          file_rec.additional_data.zip64 and
          file_rec.additional_data.zip64.file_offset
        then
          file_offset = file_rec.additional_data.zip64.file_offset
        end
        in_stream:set_position(file_offset + 1)

        local local_file_rec = self:parse_local_file_header()
        if (local_file_rec.additional_data ~= '') then
          local_file_rec.additional_data = self:parse_additional_data(local_file_rec.additional_data)
          if local_file_rec.additional_data.zip64 then
            self:fill_zip64(local_file_rec)
          end
        end

        local data_size = local_file_rec.compressed_size
        local bit_3_is_set = ('< I2'):unpack(local_file_rec.bit_flag) & (1 << 2) > 0
        if bit_3_is_set then
          data_size = file_rec.compressed_size
          if
            (data_size == max_ui4) and
            file_rec.additional_data and
            file_rec.additional_data.zip64 and
            file_rec.additional_data.zip64.compressed_size
          then
            data_size = file_rec.additional_data.zip64.compressed_size
          end
        else
          data_size = local_file_rec.compressed_size
          if
            (data_size == max_ui4) and
            local_file_rec.additional_data and
            local_file_rec.additional_data.zip64 and
            local_file_rec.additional_data.zip64.compressed_size
          then
            data_size = local_file_rec.additional_data.zip64.compressed_size
          end
        end
        in_stream:set_relative_position(data_size)

        if bit_3_is_set then
          local_file_rec.post_rec = self:parse_post_file_rec()
        end

        result.local_file_recs[i] = local_file_rec
      end

      -- HackIt: theoretically there may be more file recs than <num_entries_on_disk>
    end
    return result
  end
