local implementors =
  {
    strict = request('csv.strict'),
    fast = request('csv.fast'),
  }
implementors.default = implementors.fast

return implementors
