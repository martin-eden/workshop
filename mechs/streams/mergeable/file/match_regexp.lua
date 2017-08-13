--[[
  Same interface as for [^.string.match_regexp].

  Implementation is limited.
    Maximum length of possible capture is <chunk_size>.
]]

local chunk_size = 64 * 1024

return
  function(self, pattern)
    local orig_pos = self:get_position()

    local part_a, part_b

    part_a = ''
    part_b = self:read(chunk_size)

    local window

    while (part_b ~= '') do
      part_a = part_b
      part_b = self:read(chunk_size) or ''

      window = part_a .. part_b

      local start, finish = window:find(pattern)
      if start then
        self:set_relative_position(-#window + finish)
        return window:sub(start, finish)
      end
    end
    self:set_position(orig_pos)
  end
