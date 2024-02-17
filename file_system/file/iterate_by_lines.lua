return
  {
    f = nil,
    init =
      function(self, f)
        assert_userdata(f)
        assert(io.type(f) == 'file')
        self.f = f
      end,
    get_next_line =
      function(self)
        return self.f:read('L')
      end,
  }
