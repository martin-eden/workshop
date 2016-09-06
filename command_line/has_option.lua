-- Checks command line for presence given option like '--verbose'

local has_option =
  function(option)
    local result
    for i = 1, #_G.arg do
      if (arg[i] == option) then
        result = true
        break
      end
    end
    return result
  end

return has_option
