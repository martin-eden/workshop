return
  function(self, seq)
    local seq_passer = new(self.c_sequence)
    seq_passer:init(seq)
    self.levels = {seq_passer}
    self.cur_level = 1
  end
