local implementors =
  {
    generic = request('csv.generic'),
    specific = request('csv.specific'),
  }
implementors.default = implementors.specific

return implementors
