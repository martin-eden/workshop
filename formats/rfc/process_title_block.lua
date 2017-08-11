local trim = request('!.string.trim')

return
  function(block, result)
    local title_str
    if (#block > 0) then
      title_str = {}
      for i = 1, #block do
        title_str[i] = trim(block[i])
      end
      title_str = table.concat(title_str, ' ')
    end
    result.title = title_str
  end
