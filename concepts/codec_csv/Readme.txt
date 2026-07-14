CSV (comma-separated values) codec

Here is stream encoder and decoder for CSV data.

CSV has flavors in what fields separator to use.

This implementation is uses "," as fields separator.
If you need another delimiter go change "common/Syntax.lua".

Implementation uses ASCII 10 ('\n') as records separator.
If you need ASCII 13 10 ('\r\n') -- preprocess data.

-- Martin, 2026-07-14
