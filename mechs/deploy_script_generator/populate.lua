--[[
  Prepare list of files to copy.

  - tbl ----- tbl ----+------------+- -> nil
   (self)  (modules)  +--- str ----+
                       (deploy_dir)

  modules - root module names. List of strings.
  deploy_dir - name of directory where to copy that modules.
    Default: "deploy".
]]

local get_modules_dependencies = request('!.system.get_modules_dependencies')
local get_module_location = request('!.system.get_module_location')

local add_dir_postfix = request('!.string.file_name.add_dir_postfix')
local strip_updirs = request('!.string.file_name.strip_updirs')

return
  function(self, modules, deploy_dir)
    deploy_dir = deploy_dir or 'deploy'
    assert_string(deploy_dir)
    deploy_dir = add_dir_postfix(deploy_dir)

    self.bash_script_writer:delete_dir(deploy_dir)

    local files = get_modules_dependencies(modules)
    for i = 1, #files do
      files[i] = get_module_location(files[i])
      local src = files[i]
      local dest = deploy_dir .. strip_updirs(src)
      self.bash_script_writer:copy_file(src, dest)
    end

    if self.deploy_docs then
      local docs = self:get_docs(files)
      for i = 1, #docs do
        local src = docs[i]
        local dest = deploy_dir .. strip_updirs(src)
        self.bash_script_writer:copy_file(src, dest)
      end
    end
  end
