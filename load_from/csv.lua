local implementors =
  {
    general = request('csv.via_parser'),
    custom = request('csv.via_custom_parser'),
  }
implementors.default = implementors.general

return implementors
