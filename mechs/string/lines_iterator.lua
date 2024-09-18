--[[
  String lines iterator class.

  Interface

    init(self, s)

      Set base string with lines to iterate.

    get_next_line(self): line

      Return next line. Return "nil" if we beyond last line.
]]

-- Last mod.: 2024-09-18

local get_next_line = request('!.string.get_next_line')

return
  {
    s = nil,
    idx_start = nil,

    init =
      function(self, s)
        assert_string(s)
        self.s = s
        self.idx_start = nil
      end,

    get_next_line =
      function(self)
        local result

        self.idx_start, result = get_next_line(self.s, self.idx_start)

        --[[
          "nil" in "nil, result = get_next_line(s, start)"
          means that this is last line,
          "nil" in "get_next_line(s, nil)" means get first line.
          Avoiding this collision.
        ]]
        if is_nil(self.idx_start) then
          self.idx_start = #self.s + 1
        end

        return result
      end,
  }

--[[
  2018-02
  2024-02
  2024-09
]]
