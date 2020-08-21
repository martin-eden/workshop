--[[
  In Firmata format all data bytes have 8th bit clear. And all command
  bytes have 8th bit set.

  So theoretically we may start processing data even from middle of
  data stream. But this implementation dont like this. For simplicity
  and cause no practical case encountered yet.
]]

local sysex_start =
  request('!.concepts.firmata.protocol.signatures').sysex_start

local parsers =
  {
    -- is_request ?
    [true] =
      {
        sysex = request('^.request.sysex.parsers'),
        base = request('^.request.parsers'),
      },
    [false] =
      {
        sysex = request('^.reply.sysex.parsers'),
        base = request('^.reply.parsers'),
      },
  }

return
  function(self, is_request, results)
    assert_boolean(is_request)

    local cur_char = self.stream:get_slot()

    if not cur_char then
      return
    end

    local type_id = cur_char:byte()
    local is_sysex
    local chunk
    local parser_rec

    local orig_pos = self.stream:get_position()

    if (type_id & 0x80 == 0) then
      local msg =
        ('Current byte (%02X) have 8th bit clear, not a command.'):
        format(type_id)
      error(msg)
    elseif (type_id == sysex_start) then
      is_sysex = true
      type_id, chunk = self:frame_sysex()
      parser_rec = parsers[is_request].sysex[type_id]
    else
      type_id, chunk = self:frame_command()
      parser_rec = parsers[is_request].base[type_id]
    end

    if not chunk then
      self.stream:set_position(orig_pos)
      return
    end

    if not parser_rec then
      local cmd_type = is_sysex and 'sysex' or 'base'
      local msg =
        ('No parser found. (type: %s, id: %02X, chunk: %s)'):
        format(cmd_type, type_id, self:dump_chunk(chunk))
      error(msg)
    end

    local record = parser_rec.parser(self, chunk, type_id)

    if not record then
      self.stream:set_position(orig_pos)
      return
    end

    record.type = parser_rec.name

    table.insert(results, record)

    return true
  end
