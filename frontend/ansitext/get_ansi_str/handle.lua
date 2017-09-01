local mode_numbers = request('mode_numbers')
local foregrounds = request('foregrounds')
local backgrounds = request('backgrounds')

return
  function(e)
    if is_string(e) then
      return e
    end
    assert_table(e)

    local result = ''

    local mode = e.mode
    local fg = e.fg
    local bg = e.bg
    if mode or fg or bg then
      local modes_seq = {}

      if is_table(mode) then
        for i = 1, #mode do
          modes_seq[#modes_seq + 1] = mode_numbers[mode[i]]
        end
      else
        modes_seq[#modes_seq + 1] = mode_numbers[mode]
      end

      if fg then
        modes_seq[#modes_seq + 1] = foregrounds[fg]
      end

      if bg then
        modes_seq[#modes_seq + 1] = backgrounds[bg]
      end

      result = '\027[' .. table.concat(modes_seq, ';') .. 'm'
    end

    return result
  end
