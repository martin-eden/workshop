local parse = request('!.mechs.generic_loader')
local syntax = request('load.syntax')
local preprocess = request('load.preprocess')

return
  function(str)
    local str, prefix_rec, posfix_rec = preprocess(str)
    local data_struc = parse(str, syntax)
    if data_struc then
      if prefix_rec then
        table.insert(data_struc, 1, prefix_rec)
      end
      if posfix_rec then
        table.insert(data_struc, posfix_rec)
      end
    end
    return data_struc
  end
