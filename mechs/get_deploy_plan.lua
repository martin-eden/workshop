-- Create deploy filelist

--[[
  Author: Martin Eden
  Last mod.: 2026-09-24
]]

--[[
  For list of pathnames and deploy directory, return list of records
  "from-to" with pathnames.

  Optionally can add to this list documentation files from
  related directories.

  Input
    [t] PathsList -- list of file names
    [t] Config -- deploy configuration
      [?s] deploy_dir -- deploy directory
      [?b] include_docs -- also locate and copy documentation files

  Output
    [t] -- list of tables (pairs)
      1 [s] source pathname
      2 [s] destination pathname
]]

local get_docs_filelist = request('get_deploy_plan.get_docs_filelist')
local DefaultConfig = request('get_deploy_plan.DefaultConfig')
local add_separator = request('!.concepts.path_name.add_separator')
local add_to_list = request('!.concepts.list.add_item')
local rebase_to = request('!.concepts.path_name.rebase_to')

local get_deploy_plan =
  function(PathsList, ArgConfig)
    local Config = new(DefaultConfig, ArgConfig)

    local deploy_dir = Config.deploy_dir
    local include_docs = Config.include_docs

    assert_string(deploy_dir)

    deploy_dir = add_separator(deploy_dir)

    local DocFiles = { }
    if include_docs then
      DocFiles = get_docs_filelist(PathsList)
    end

    local Result = { }

    for _, src_pathname in ipairs(PathsList) do
      local dest_pathname = rebase_to(deploy_dir, src_pathname)

      add_to_list(Result, { src_pathname, dest_pathname })
    end

    for _, src_pathname in ipairs(DocFiles) do
      local dest_pathname = rebase_to(deploy_dir, src_pathname)

      add_to_list(Result, { src_pathname, dest_pathname })
    end

    return Result
  end

-- Export:
return get_deploy_plan

--[[
  2016
  2017 # #
  2018 # # # #
  2026 # # # # #
  2026-08-13
  2026-09-24
]]
