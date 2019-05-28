local command_regexp =
  ('^[%c-%c]([%c-%c]*)'):format(0x80, 0xFF, 0x00, 0x7F)

return
  function(self)
    local cmd = self.stream:get_slot():byte()
    local chunk = self.stream:match_regexp(command_regexp)

    if not chunk then
      return
    end

    return cmd, chunk
  end
