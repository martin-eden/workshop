List interface

It's designed as constant methods metatable on given list table.

There are lot of convenience methods.

Example:

  local ListClass = request('!.concepts.List.Interface')

  local List = ListClass.create({})

  List:Add('a')
  -- { 'a' }

  List:Add('b')
  -- { 'a', 'b' }

  List:Remove()
  -- { 'b' }
