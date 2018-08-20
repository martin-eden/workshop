--[[
  Generic file converter interface.

  Usage core:

    Fill (<f_in_name> <f_out_name>)
    Call <init>
    Call <run>

  For useful usage you'll need to override some of the following
  methods: (<load> <parse> <transform> <compile> <save>)

  Execution stages:

    arg/result:  file string  table     table   string file
                   ~~~~~  ~~~~~~ ~~~~~~~~~ ~~~~~~~  ~~~~~
    method:        load   parse  transform compile  save
]]

return
  {
    -- parameters
    f_in_name = '',
    f_out_name = '',
    action_name = '',
    load = request('!.file.text_file_as_string'),
    parse = request('!.formats.lua_table_code.load'),
    transform = request('!.function.identity'),
    compile = request('!.table.as_string'),
    save = request('!.string.save_to_file'),
    -- runmes
    run = request('run'),
    -- implementation
    say = request('say'),
    init = request('init'),
  }
