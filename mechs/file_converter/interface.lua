-- Generic file converter interface

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

--[[
  Usage core: call <run>.

  For useful usage you'll need to override some of the following
  methods: (<load> <parse> <transform> <compile> <save>).

  Execution stages:

    arg/result:  file string  table     table   string file
                   ~~~~~  ~~~~~~ ~~~~~~~~~ ~~~~~~~  ~~~~~
    method:        load   parse  transform compile  save
]]

-- Export:
return
  {
    -- parameters
    f_in_name = '',
    f_out_name = '',
    action_name = 'Generic file conversion',
    load = request('!.convert.file_to_str'),
    parse = request('!.function.identity'),
    transform = request('!.function.identity'),
    compile = request('!.function.identity'),
    save = request('!.convert.file_from_str'),
    -- runmes
    run = request('run'),
    -- implementation
    say = request('say'),
    init = request('init'),
  }

--[[
  2017 # # # # #
  2018 # # # #
  2026-05-05
]]
