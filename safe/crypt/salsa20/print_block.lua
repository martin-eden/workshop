return
  function(block, annotation)
    annotation = annotation or ''
    print(('-- %s'):format(annotation))
    for i = 1, 4 do
      print(
        ('%08X %08X %08X %08X'):
        format(
          block[(i - 1) * 4 + 1],
          block[(i - 1) * 4 + 2],
          block[(i - 1) * 4 + 3],
          block[(i - 1) * 4 + 4]
        )
      )
    end
  end
