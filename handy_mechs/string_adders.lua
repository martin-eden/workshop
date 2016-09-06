local string_adders =
  {
    array = request('string_adders.consolidable_array'),
    file = request('string_adders.file'),
  }
string_adders.default = string_adders.file

return string_adders
