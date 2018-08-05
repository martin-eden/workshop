return
  {
    -- parameters
    f_in_name = '',
    f_out_name = '',
    action_name = '',
    load = request('!.file.text_file_as_string'),
    parse = request('!.formats.lua_table_code.load'),
    compile = request('!.table.as_string'),
    save = request('!.string.save_to_file'),
    -- runmes
    run = request('run'),
    -- implementation
    say = request('say'),
    init = request('init'),
  }
