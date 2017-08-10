local representer = request('!.mechs.number.representer.interface')

representer =
  new(
    representer,
    {
      type = 'frequency',
      digits_display = 3,
    }
  )
representer:init()

return
  function(n)
    return representer:represent(n)
  end
