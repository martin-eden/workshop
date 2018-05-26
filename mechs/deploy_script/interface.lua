--[[
  Create Bash script to copy all needed Lua modules in separate
  directory.

  get_script(
    modules: table - list of strings - root modules
    opt deploy_dir: string - name of directory where copy that modules
      default "deploy"
  )


  Create Bash script and save it in file.

  save_script(
    modules: table - list of strings - see get_script()
    opt script_name: string - name of Bash script
      default "deploy.sh"
    opt deploy_dir: string - see get_script()
  )
]]


return
  {
    get_script = request('get_script'),
    save_script = request('save_script'),
  }
