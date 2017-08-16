local chunk_fmt = '< ' .. ('I4 '):rep(16)
local chunk_len = chunk_fmt:packsize()

return
  function(self)
    local start_pos = 1
    local chunk
    local block_num = 1
    -- for test set block_num to 7
    block_num = 7
    while (start_pos + chunk_len - 1 <= #self.input) do
      chunk = {chunk_fmt:unpack(self.input, start_pos)}
      start_pos = chunk[#chunk]
      chunk[#chunk] = nil

      local block = self:gen_block(block_num)
      for i = 1, #block do
        block[i] = block[i] ~ chunk[i]
      end

      self.output = self.output .. chunk_fmt:pack(table.unpack(block))

      block_num = block_num + 1
    end
  end
