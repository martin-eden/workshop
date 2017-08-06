--[[
  String lines iterator class.

  Main intention - encapsulate parameters (string, index) to object.
]]

local get_next_line = request('!.string.lines.get_next_line')

return
  {
    s = nil,
    idx_start = nil,
    init =
      function(self, s)
        assert_string(s)
        self.s = s
        self.idx_start = 1
      end,
    get_next_line =
      function(self)
        local result
        self.idx_start, result = get_next_line(self.s, self.idx_start)
        --[[
          nil new index means that this is last line,
          nil starting index means get first line.
          Avoiding this collision.
        ]]
        self.idx_start = self.idx_start or (#self.s + 1)
        return result
      end,
  }
