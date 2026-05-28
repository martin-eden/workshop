-- Generates Bash script to copy Lua modules and documentation

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

return
  {
    deploy_docs = true,
    populate = request('populate'),
    get_script = request('get_script'),
    save_script = request('save_script'),
    --
    bash_script_writer = request('!.concepts.BashScriptWriter.Interface'),
    get_docs = request('get_docs'),
  }

--[[
  2016
  2017 # #
  2018 # # # #
  2026-05-28
]]
