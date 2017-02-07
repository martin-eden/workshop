local struc

local init =
  function()
    struc = {}
    struc.is_folded = false
  end

local get_checkpoint =
  function()
    -- print('Checkpoint.')
    return #struc
  end

local rollback =
  function(checkpoint)
    -- local orig_len = #struc
    for i = checkpoint + 1, #struc do
      struc[i] = nil
    end
    -- print(('Rolled back from %d to #%d.'):format(orig_len, checkpoint))
  end

local mark =
  function(start, finish, name, data)
    struc[#struc + 1] =
      {
        start = start,
        finish = finish,
        name = name,
        data = data,
      }
    -- print(('Marked %s(%d,%d)'):format(name, start, finish))
  end

local fold_struc =
  function()
    if (#struc >= 2) then
      local src_idx = 2
      local dest_idx = 1
      local result = {struc[1]}
      repeat
        if
          (result[dest_idx].start < struc[src_idx].start) or
          (result[dest_idx].finish > struc[src_idx].finish)
        then
          dest_idx = dest_idx + 1
          result[dest_idx] = struc[src_idx]
        else
          local start_idx = dest_idx
          repeat
            start_idx = start_idx - 1
          until
            (start_idx < 1) or
            (result[start_idx].start < struc[src_idx].start) or
            (result[start_idx].finish > struc[src_idx].finish)

          start_idx = start_idx + 1
          local dest_table =
            {
              start = struc[src_idx].start,
              finish = struc[src_idx].finish,
              name = struc[src_idx].name,
              data = struc[src_idx].data,
            }
          local copy_idx = start_idx
          for i = start_idx, dest_idx do
            dest_table[#dest_table + 1] = result[i]
          end
          result[start_idx] = dest_table
          dest_idx = start_idx
        end
        src_idx = src_idx + 1
      until (src_idx > #struc)
      dest_idx = dest_idx + 1
      while result[dest_idx] do
        result[dest_idx] = nil
        dest_idx = dest_idx + 1
      end
      struc = result
    end
    struc.is_folded = true
  end

local get_struc =
  function()
    if not struc.is_folded then
      fold_struc()
    end
    return struc
  end

return
  {
    init = init,
    mark = mark,
    get_struc = get_struc,
    get_checkpoint = get_checkpoint,
    rollback = rollback,
  }
