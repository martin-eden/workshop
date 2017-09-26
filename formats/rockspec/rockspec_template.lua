return
[[
package = $package
version = 'scm-1'

source = {
  url = $repository_url,
  branch = $repository_branch,
}

description = {
  summary = $short_desc,
  detailed = $description,
  license = $license,
}

dependencies = {
  'lua ~> 5.3',
}

build = {
  type = 'builtin',
  install = {
    bin = $shell_scripts,
  },
  modules = $modules,
}
]]
