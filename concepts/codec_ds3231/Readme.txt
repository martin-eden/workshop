This is codec for raw data from hardware module DS3231 (real-time clock)

"Parse.lua" converts string of data to structured Lua table.
"Compile.lua" converts structured Lua table to string of data.

Core module is "ds3231_ranges_tree.is".

That's tree of named bits segments. Tree is stored in Itness format,
accessible both for humans and computers.

Result Lua table from "Parse" has exactly same structure.
But data values is changed from strings with bits to integers
or booleans.


That's second implementation of this module. First implementation was
complete in 2020. We respect it and overwriting it to make things better.

Unlike previous implementation we do less post-processing of data.

For example, before we returned ".wave_freq = 4096".
That's not actual data. Actual data is wave number 2.
And we will return ".wave_freq_num = 2".

( We are codec, not pretty-printer. We are expected to compile
reasonably changed data back. And we can't meet this expectation
say for ".wave_freq = 5197". )

-- Martin, 2026-05-07
