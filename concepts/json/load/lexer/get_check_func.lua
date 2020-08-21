local get_token = request('get_token')

return
  function(syntel_name)
    return
      function(s, s_pos)
        local token, new_pos = get_token(s, s_pos)
        if (token == syntel_name) then
          return true, new_pos
        end
        return false, s_pos
      end
  end
