-- Return shell command to delete directory. GNU/bash assumed.

-- Last mod.: 2024-02-17

return
  function(dir_name)
    return ('rm -r %s'):format(dir_name)
  end
