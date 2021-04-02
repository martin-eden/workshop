DS3231 real-time clock data parser and compiler.

Well, I'm proud of this implementation. (For that stage of my
professional development when it was written.) DS3231 is integrated
circuit (microscheme) that stores and updates current time (just
clock). It stores data in somewhat obscure format but for this
overview we can look on it as on array of bytes.

"parse.lua" parses this array to structured Lua table.

"compile.lua" compiles that table to array of bytes.

Challenge was to make it robust to raw data and Lua table data
non-conforming to datasheet. And to keep code in simple modules,
typically fitting half of screen.

This achieved via multi- logical levels approach and verify-validate-
process concept.

Multi- logical levels approach means that we work at successive
logical layers, each having limited scope. Checking from byte-level
(that data in array are integers in 0..255 range) to bit-mask level
(that specific bits are ones or zeros) to numbers level (that
specific bit stripes represent numbers in certain range) up to
common-sense level (that those numbers represent possible time or
date). Compiling passes same levels in reverse order.

Verify-validate-process concept means how we handle input data.
"Verify" means that we check data on logical level we working and
produce list of errors (if there are any). "Validate" means that we
correct that errors by changing input data. And "process" means that
we produce result for next level without distracting on checks of
input data.

We do not check output data. So if "process" returns string when
next-level "verify" assumes list of integers, it will blow. We can
add some "verify-result" stage to keep concept flawless, but there
was no practical need in that.

Other are implementation details. Levels passed as Lua table with
array of verify-validate-process records. "generic_convert.lua"
handles it. "parse.lua" and "compile.lua" prepare that table for their
tasks. And other modules are verify-validate-process functions and
their utility subfunctions.

Code base written in 2020-08/2020-09.

2021-04-02
