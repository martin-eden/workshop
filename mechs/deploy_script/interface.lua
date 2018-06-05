--[[
  Create Bash script to copy all needed Lua modules in separate
  directory.

  Workflow:

    * Clone.

    * -+----------------+- populate -+- save_script -+-
       +- .deploy_docs -+            +- get_script --+


  .deploy_docs -> bool

    Flag to include documentation files in deploy package.
]]

return
  {
    deploy_docs = true,
    populate = request('populate'),
    get_script = request('get_script'),
    save_script = request('save_script'),
    --
    bash_script_writer = request('!.mechs.bash_script_writer.interface'),
    get_docs = request('get_docs'),
  }
