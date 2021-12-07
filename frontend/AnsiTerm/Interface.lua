local CSI = '\027['

return
  {
    ClrEol = CSI .. 'K',
    ScreenClear = CSI .. '2J',
    ScreenClearToStart = CSI .. '1J',
    ScreenClearToEnd = CSI .. 'J',
    CursorHide = CSI .. '?25l',
    CursorShow = CSI .. '?25h',
    CursorGotoXY =
      function(x, y)
        assert_integer(x)
        assert_integer(y)
        return (CSI .. '%d;%dH'):format(y, x)
      end,
    GetScreenSize =
      function()
        io.write('\027[18t')
        local result = ''
        while true do
          local c = io.read(1)
          result = result .. c
          if c == 't' then
            break
          end
        end
        local width, height
        if is_string(result) then
          height, width = result:match('\027%[%d+;(%d+);(%d+)t')
          height = tonumber(height)
          width = tonumber(width)
          -- print('!', 'screen size', ('(%d x %d)'):format(width, height))
        end
        return width, height
      end,
  }
