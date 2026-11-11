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

    [t] -- list of file names
    [t] -- deploy configuration
      deploy_dir [?s] -- deploy directory
      include_docs [?b] -- also locate and copy documentation files

  Output

    [t] -- list of pairs
      1 [s] source pathname
      2 [s] destination pathname
]]

local get_docs_filelist = request('get_deploy_plan.get_docs_filelist')
local default_config = request('get_deploy_plan.default_config')
local add_separator = request('!.concepts.path_name.add_separator')
local add_to_list = request('!.concepts.list.add_item')
local rebase_to = request('!.concepts.path_name.rebase_to')

return
  function(pathnames, arg_config)
    local config = new(default_config, arg_config)

    local deploy_dir = config.deploy_dir
    assert_string(deploy_dir)
    deploy_dir = add_separator(deploy_dir)

    local include_docs = config.include_docs

    local docs = { }
    if include_docs then
      docs = get_docs_filelist(pathnames)
    end

    local result = { }
    for _, src_pathname in ipairs(pathnames) do
      add_to_list(
        result,
        { src_pathname, rebase_to(deploy_dir, src_pathname) }
      )
    end
    for _, src_pathname in ipairs(docs) do
      add_to_list(
        result,
        { src_pathname, rebase_to(deploy_dir, src_pathname) }
      )
    end

    return result
  end

--[[
  2016 #
  2017 # #
  2018 # # # #
  2026 # # # # # # #
]]
