local CSI = '\027['

return
  {
    ClrEOL = CSI .. 'K',
    ScreenClear = CSI .. '2J',
    ScreenClearToStart = CSI .. '1J',
    ScreenClearToEnd = CSI .. 'J',
    CursorHide = CSI .. '?25l',
    CursorShow = CSI .. '?25h',
    CursorGotoXY =
      function(x, y)
        return (CSI .. '%d;%dH'):format(y, x)
      end,
    GetScreenSize =
      function()
        io.write(CSI .. '18t')
        local Response = ''
        while true do
          local c = io.read(1)
          Response = Response .. c
          if (c == 't') then
            break
          end
        end
        local Height, Width = Response:match('\027%[%d+;(%d+);(%d+)t')
        Height = tonumber(Height)
        Width = tonumber(Width)
        return Width, Height
      end,
  }
