--[[
  Generate script and save it to file.

  - tbl ----+-------------+- -> nil
   (self)   +---- str ----+
             (script_name)

  script_name - name of Bash script. Default: "deploy.sh".
]]

return
  function(self, script_name)
    script_name = script_name or 'deploy.sh'
    self.bash_script_writer:save_script(script_name)
  end
