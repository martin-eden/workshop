local result =
  {
    array = request('string_adders.consolidable_array'),
    file = request('string_adders.file'),
  }
result.default = result.file

return result
