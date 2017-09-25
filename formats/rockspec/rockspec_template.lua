return
[[
package = '$package'
version = 'scm-1'

source = {
  url = '?',
}

description = {
  summary = '?',
  license = '?',
  homepage = '?',
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
