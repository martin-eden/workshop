TSV (tab-separated values) codec

TSV is nice and simple format for list of lists of strings
which doesn't contain bytes 009 010.

Inner list items are called "fields" and separated by 009 (tab).
Outer list items are called "records" and separated by 010 (newline).

-- Martin, 2026-07-14
