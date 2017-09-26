local get_cmd_copy = request('!.bare.file_system.get_cmd_copy')
local get_cmd_mkdir = request('!.bare.file_system.get_cmd_mkdir')
local get_modules_dependencies = request('!.system.get_modules_dependencies')
local get_module_location = request('!.system.get_module_location')
local strip_updirs = request('!.string.file_name.strip_updirs')

local mark_directory_created =
  function(dir_name, directories_created)
    local parent_path = ''
    for parent_dir in dir_name:gmatch('(.-)/') do
      parent_path = parent_path .. parent_dir
      directories_created[parent_path] = true
      parent_path = parent_path .. '/'
    end
    directories_created[dir_name] = true
  end

local add_dir_postfix = request('!.string.file_name.add_dir_postfix')

local get_deploy_script =
  function(modules, deploy_dir)
    deploy_dir = deploy_dir or 'deploy'
    deploy_dir = add_dir_postfix(deploy_dir)

    local files = get_modules_dependencies(modules)
    for i = 1, #files do
      files[i] = get_module_location(files[i])
    end
    table.sort(files)

    local result = {}

    local directories_created = {}
    for i = 1, #files do
      local source = files[i]
      local dest = deploy_dir .. strip_updirs(files[i])
      local directory = dest:match('(.+)/')
      if not directories_created[directory] then
        mark_directory_created(directory, directories_created)
        result[#result + 1] = get_cmd_mkdir(directory)
      end
      result[#result + 1] = get_cmd_copy(source, dest)
    end
    result[#result + 1] = ''
    result = table.concat(result, '\n')
    return result
  end

local save_deploy_script =
  function(modules, script_name, deploy_dir)
    script_name = script_name or 'deploy.sh'
    local f, err_msg = io.open(script_name, 'w+')
    if not f then
      error(err_msg)
    end
    f:write('#!/bin/bash', '\n')
    f:write(get_deploy_script(modules, deploy_dir))
    f:close()
  end

return
  {
    get_script = get_deploy_script,
    save_script = save_deploy_script,
  }
