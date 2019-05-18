return
  function(chunk)
    io.write('> ')
    for i = 1, #chunk do
      local char_code = chunk:byte(i, i)
      io.write(('%02X '):format(char_code))
    end
    io.write('\n')
  end
