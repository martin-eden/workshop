Here is JSON codec

JSON string is parsed to Lua structure by "load.lua".
Lua structure is compiled to JSON string by "save.lua".

And actually we have here four (!) parsers:

  * [via_hack] converts JSON string to Lua code and
    loads it.

    That's not correct but still works in some cases.
    This code here is mostly for bragging. It's fastest.

  * [via_lexer] uses traditional lexems->structure
    approach. It's reasonably effective and safe.

    Implementation may be revisited and restructured.

  * [via_parser.strict] is grammar-driven

    Efforts were made to make grammar readable and close
    to official RFC format specification.

    It's slow but provably correct.

  * [via_parser.fast] is also grammar-driven

    Efforts were made to make it faster than "strict" grammar.

    Code is obscure because of using regexps (for speed).

    It's near 8 times faster than "strict" and still slower
    than "via_lexer".

First implementation was "strict". It was easy and pleasant to write
and I used it as reference for other ones.

-- Martin, 2026-08
