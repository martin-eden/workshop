List interface

It's designed as constant methods metatable on given list table.

There are lot of convenience methods.

Example:

  local ListClass = request('!.concepts.List.Interface')

  local List = ListClass.create({})

  List:Insert('a')
  -- { 'a' }

  List:Insert('b')
  -- { 'a', 'b' }

  List:Remove()
  -- { 'b' }
