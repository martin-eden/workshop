-- Parse pathname string to list of names

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

--[[
  Contract

  Input is a non-empty POSIX pathname string.

  Output is a list of name segments, built from these rules:

    * Segments equal to "" or "." are dropped, except that a
      trailing "" is kept when the pathname denotes a directory,
      and a leading "" is kept when the pathname is absolute.

    * If, after dropping "" and ".", no name segments remain and
      the pathname is not absolute, the single segment "." is used
      (this is how "." and "./" are represented).

    * If the pathname is absolute, first list item is "".

    * If the pathname is a directory (ends in "/", ".", or ".."),
      last list item is "".

  List length is at least one. It equals one only for a plain
  relative name with no path separators, like "a".
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')
local split_string = request('!.string.split')
local Syntels = request('Syntels')

local sep = Syntels.separator
local empty = Syntels.empty
local self_dir = Syntels.self_dir
local upper_dir = Syntels.upper_dir

local pathname_from_str =
  function(path_name)
    assert_string(path_name)

    if (path_name == empty) then
      error('Empty pathname.')
    end

    local Segments = split_string(path_name .. sep, sep)

    local is_absolute = (Segments[1] == empty)
    local last_segment = Segments[#Segments]
    local is_directory =
      (last_segment == empty) or
      (last_segment == self_dir) or
      (last_segment == upper_dir)

    local Names = { }
    for _, segment in ipairs(Segments) do
      if (segment ~= empty) and (segment ~= self_dir) then
        add_to_list(Names, segment)
      end
    end

    if (#Names == 0) and not is_absolute then
      add_to_list(Names, self_dir)
    end

    local Result = { }

    if is_absolute then
      add_to_list(Result, empty)
    end

    for _, name in ipairs(Names) do
      add_to_list(Result, name)
    end

    if is_directory then
      add_to_list(Result, empty)
    end

    return Result
  end

-- Export:
return pathname_from_str

--[[
  Notes

    * POSIX pathnames are elegant

      Don't treat them as strings. Treat them as slash-separated
      strings list.

    * Empty string as pathname is illegal in POSIX

      This code will process it as "/". But empty string is stupid,
      so empty string is under assert().

    * ".." element

      It does not interpret "a/b/.." as "a/" because "b" may be
      symlink to another directory.

  Examples (Itness format):

    '' -> error

    / -> ( [] [] )
    /. -> ditto

    . -> ( . [] )
    ./ -> ditto

    .. -> ( .. [] )
    ../ -> ditto
    ./.. -> ditto

    a -> ( a )

    /a -> ( [] a )

    a/ -> ( a [] )

    /a/ -> ( [] a [] )

    a/b -> ( a b )

    /.. -> ( [] .. [] )

    ././..//a/./. -> ( .. a [] )
]]

--[[
  2016-09
  2018-06
  2026-04 # # # #
  2026-06-11
  2026-06-12
  2026-08-08
]]
