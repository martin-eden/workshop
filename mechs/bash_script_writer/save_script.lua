--[[
  Generate script and save it to given file.

  - tbl ---+-----------+- -> nil
   (self)  +--- str ---+
            (file_name)

  file_name - Bash script file name. Default: "run.sh".
]]

local safe_open = request('!.file_system.file.safe_open')

return
  function(self, file_name)
    file_name = file_name or 'run.sh'
    assert_string(file_name)

    local script_str = self:get_script()

    local f = safe_open(file_name, 'w')
    f:write(script_str)
    f:close()
  end
