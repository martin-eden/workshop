return
[[
#!/bin/bash

in_file=$1
out_file=$2

lua_call="
do
  require('$package.workshop.base')
  local run = request('$package.$lua_main')
  run('$in_file', '$out_file')
end
"

echo $lua_call | lua
]]
