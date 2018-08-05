local file_size = request('!.file.get_size')
local represent_size = request('!.number.represent_size')
local table_to_str = request('!.table.as_string')

return
  function(self)
    local header = ('--[ %s ]'):format(self.action_name)
    self:say(header)
    self:say(
      ('Loading "%s" [%s].'):format(
        self.f_in_name,
        represent_size(file_size(self.f_in_name))
      )
    )
    local data = self.load(self.f_in_name)
    if data then
      self:say('Parsing.')
      local parse_result = self.parse(data)
      if parse_result then
        self:say('Compiling.')
        local compile_result = self.compile(parse_result)
        if compile_result then
          if is_table(compile_result) then
            compile_result = table_to_str(compile_result)
            self:say('Serializing table result.')
          end
          assert_string(compile_result)
          self:say(
            ('Saving "%s" [%s].'):format(
              self.f_out_name,
              represent_size(#compile_result)
            )
          )
          self.save(self.f_out_name, compile_result)
        else
          self:say('Compile failed.')
        end
      else
        self:say('Parse failed.')
      end
    end
    self:say('')
  end
