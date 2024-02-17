local file_size = request('!.file_system.file.get_size')
local represent_size = request('!.number.represent_size')
local table_to_str = request('!.table.as_string')

return
  function(self)
    self:init()

    local header = ('--[ %s ]'):format(self.action_name)
    self:say(header)
    self:say(
      ('Loading "%s" [%s].'):format(
        self.f_in_name,
        represent_size(file_size(self.f_in_name))
      )
    )
    local data = self.load(self.f_in_name)
    assert(data, 'Loading failed.')

    self:say('Parsing.')

    local parse_result = self.parse(data)
    assert(parse_result, 'Parse failed.')

    self:say('Transforming.')

    local transform_result = self.transform(parse_result)
    assert('Transform failed.')

    self:say('Compiling.')

    local compile_result = self.compile(transform_result)
    assert(compile_result, 'Compile failed.')

    self:say(
      ('Saving "%s" [%s].'):format(
        self.f_out_name,
        represent_size(#compile_result)
      )
    )
    self.save(self.f_out_name, compile_result)

    self:say('')
  end
