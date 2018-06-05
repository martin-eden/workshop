--[[
  Generate string with script.

  - tbl - -> str
   (self)
]]

return
  function(self)
    return self.bash_script_writer:get_script()
  end
