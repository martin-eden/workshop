-- Execute file conversion

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local get_file_size = request('!.file_system.file.get_size')
local represent_size = request('!.number.represent_size')

local execute_conversion =
  function(self)
    self:init()

    local header = ('--[ %s ]'):format(self.action_name)
    self:say(header)
    self:say(
      ('Loading "%s" [%s].'):format(
        self.f_in_name,
        represent_size(get_file_size(self.f_in_name))
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

-- Export:
return execute_conversion

--[[
  2017 # #
  2018 # # # #
  2026-05-05
]]
