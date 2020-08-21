local minimal_handlers = request('^.^.minimal.handlers.interface')

local result =
  new(
    minimal_handlers,
    {
      wrap_array = request('wrap_array'),
      wrap_object = request('wrap_object'),
    }
  )

return result
