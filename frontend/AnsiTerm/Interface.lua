local CSI = '\027['

return
  {
    ClrEol = CSI .. 'K',
    HideCursor = CSI .. '?25l',
    ShowCursor = CSI .. '?25h',
  }
