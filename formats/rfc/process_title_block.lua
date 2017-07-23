local trim_head_spaces = request('!.string.trim_head_spaces')
local trim_tail_spaces = request('!.string.trim_tail_spaces')

return
  function(block, result)
    local title_str
    if (#block > 0) then
      title_str = {}
      for i = 1, #block do
        title_str[i] = trim_head_spaces(trim_tail_spaces(block[i]))
      end
      title_str = table.concat(title_str, ' ')
    end
    result.title = title_str
  end
