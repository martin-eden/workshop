DS3231 real-time clock data parser and compiler

DS3231 is integrated circuit with battery. It provides current time,
temperature and "alarms". Alarms can set output pin to HIGH when
current time matched alarm time. Useful for waking up attached
microcontroller.

It provides data in somewhat obscure format.

Our interface accepts that data as list of bytes.

"parse.lua" parses this list of byte to structured Lua table.
"compile.lua" compiles that table to list of bytes.

Code base is written in 2020-08/2020-09.

Main user is GUI application that wants named fields with booleans
and integers.

Core of implementation is in "categorize.lua" and in "serialize.lua".

Implementation uses multi-levels data processing to get from
list of bytes to table with raw data, to table with final data
and back.

Levels of data processing is trying to be robust. If input data
does not match their interface they can "validate" it (make it valid).

As any first implementation it introduces novel methods.
Not all of them proved to be practical in my view in 2026.
So currently I'm rewriting this module.

But code is tested and works.

-- Martin, 2026-05-07
