local get_modules_dependencies = request('!.system.get_modules_dependencies')
local get_module_location = request('!.system.get_module_location')

local strip_updirs = request('!.string.file_name.strip_updirs')
local add_dir_postfix = request('!.string.file_name.add_dir_postfix')
local parse_pathname = request('!.formats.path_name.parse')

local get_cmd_copy = request('!.bare.file_system.get_cmd_copy')
local get_cmd_mkdir = request('!.bare.file_system.get_cmd_mkdir')

local get_script =
  function(modules, deploy_dir)
    deploy_dir = deploy_dir or 'deploy'
    deploy_dir = add_dir_postfix(deploy_dir)

    local files = get_modules_dependencies(modules)
    for i = 1, #files do
      files[i] = get_module_location(files[i])
      -- To do: add documentation files too: wtf.txt <name>.txt
    end
    table.sort(files)

    local result = {}

    local directories_created = {}

    local mark_directory_created =
      function(dir_name)
        local parent_path = ''
        for parent_dir in dir_name:gmatch('(.-)/') do
          parent_path = parent_path .. parent_dir
          parent_path = parent_path .. '/'
          directories_created[parent_path] = true
        end
        directories_created[dir_name] = true
      end

    for i = 1, #files do
      local source = files[i]
      local dest = deploy_dir .. strip_updirs(source)
      local directory = parse_pathname(dest).directory
      if not directories_created[directory] then
        result[#result + 1] = get_cmd_mkdir(directory)
        mark_directory_created(directory)
      end
      result[#result + 1] = get_cmd_copy(source, dest)
    end
    result[#result + 1] = ''

    result = table.concat(result, '\n')

    return result
  end

return get_script
